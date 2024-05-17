using UnityEngine;
using UnityEngine.EventSystems;


public class CapsuleDetail : MonoBehaviour , IPointerClickHandler
{   
    
    private int cid;
    private string title;
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("캡슐디테일실행");
    }

    // Update is called once per frame
    void Update()
    {
        capsuleTouch();
    }   

    public void OnPointerClick(PointerEventData eventData)
    {
        // 터치 이벤트 처리 로직 작성
        Debug.Log("AR Object Clicked!");
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
