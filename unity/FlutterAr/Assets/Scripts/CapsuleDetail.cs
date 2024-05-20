using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.XR.ARFoundation;


public class CapsuleDetail : MonoBehaviour , IPointerClickHandler
{   
    
    public int cid;
    private ARRaycastManager _arRaycastManager;
    private RaycastHit hitInfo;
    public int getCapsule;

    private ARRaycastManager arRaycastManager;
    public string title;
    // Start is called before the first frame update
    void Start()
    {
         arRaycastManager = FindAnyObjectByType<ARRaycastManager>();
        Debug.Log("캡슐디테일실행");
         if (arRaycastManager == null)
    {
        Debug.LogError("arRaycastManager is null. Please assign a valid ARRaycastManager component.");
    }
    }

    // Update is called once per frame
    void Update()
    {   
         Debug.Log("arRaycastManager: " + arRaycastManager);
         if(Input.touchCount> 0 && Input.GetTouch(0).phase== TouchPhase.Began){
            HandleTouch();
         }
    }   

     private void HandleTouch()
{
    Vector2 touchPosition = Input.GetTouch(0).position;
    Debug.Log("touchPosition: "  + touchPosition);
    List<ARRaycastHit> hits = new List<ARRaycastHit>();

    if (arRaycastManager.Raycast(touchPosition, hits, UnityEngine.XR.ARSubsystems.TrackableType.PlaneWithinPolygon))
    {
        foreach (var hit in hits)
        {
            GameObject hitObject = hit.trackable.gameObject;
            Debug.Log("hitObject: "  + hitObject);
            CapsuleDetail capsuleDetail = hitObject.GetComponent<CapsuleDetail>();

            if (capsuleDetail != null)
            {
                int cid = capsuleDetail.cid;
                string title = capsuleDetail.title;

                // 터치된 capsule 게임 오브젝트에 대한 처리 로직 작성
                Debug.Log($"Touched capsule with cid: {cid}, title: {title}");
                 }
             }
        }
        else{
            Debug.Log("감지 실패");
            Debug.Log("hits:"+hits);
        }
    }

    public void capsuleTouch2(){
        if(Input.GetMouseButtonDown(0))
        {
            Vector3 mousePos = Input.mousePosition;
            Ray screenRay = Camera.main.ScreenPointToRay(mousePos);
            if(Physics.Raycast(screenRay.origin, screenRay.direction* 1000f, out hitInfo)){
                if(hitInfo.collider.CompareTag("capsule") ){
                    hitInfo.collider.gameObject.SetActive(false);
                    getCapsule++;
                    Debug.Log("capsule 터치");
                }
            }
        }
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        // 터치 이벤트 처리 로직 작성
        Debug.Log("AR Object 클릭됨!!");
    }

    
     private void capsuleTouch()
    {   
        
        if (Input.touchCount > 0)
        {
            Debug.Log("레이케스트 함수 실행");
            Touch touch = Input.GetTouch(0);
            if (touch.phase == TouchPhase.Began)
            {
                Debug.Log("터치 시작");
                RaycastHit hit;
                Ray ray = Camera.main.ScreenPointToRay(touch.position);
               if (Physics.Raycast(ray, out hit))
                {
                    Debug.Log("레이케스트 물체 포착");
                    GameObject touchedObject = hit.collider.gameObject;
                    if (touchedObject.CompareTag("capsule"))
                    {
                        Debug.Log("capsule 캡슐 터치");
                        HandleTouchEvent(touchedObject);
                    }
                    if (touchedObject.CompareTag("Capsula"))
                    {
                        Debug.Log("capsula 캡슐 터치");
                        HandleTouchEvent(touchedObject);
                    }
                }
            }
        }
    }

     private void test_touch(){
         if (Input.GetTouch(0).phase == TouchPhase.Began)
        {
            // 터치 위치에서 Raycast 발생
            List<ARRaycastHit> hits = new List<ARRaycastHit>();
            if (_arRaycastManager.Raycast(Input.GetTouch(0).position, hits, UnityEngine.XR.ARSubsystems.TrackableType.PlaneWithinPolygon))
            {
                // Raycast 결과에서 오브젝트 감지
                if (hits.Count > 0)
                {
                    ARRaycastHit hit = hits[0];
                    GameObject touchedObject = hit.trackable.gameObject;
                    Debug.Log($" cd Touched object: {touchedObject.name}");
                }
            }
        }
    }
    

      void HandleTouchEvent(GameObject touchedObject)
    {
      CapsuleDetail capsuleDetail = touchedObject.GetComponent<CapsuleDetail>();
        int cid = capsuleDetail.getCid();
        string title = capsuleDetail.getTitle();
        Debug.Log($"Touched Capsule: CID={cid}, Title={title}");

    }



    public int getCid(){
        return cid;
    }
      public string getTitle(){
        return title;
    }

    //! FIXME: 5월15일, 캡슐 잡고 움직여서 위치 바꾸는거 하려 했는데 지금 단계에선 굳이인듯, 나중에 다 하고 시간 남으면 해보자. 
    public void assignCid(int cid){
        this.cid = cid;
    }
    public void assignTitle(string title){
        this.title = title;
    }
}
