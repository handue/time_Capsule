
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

// using UnityEngine.Android;

public class ArPlaceOnPlane : MonoBehaviour
{

    // TODO: 5월15일에 해야할거, 이제 유니티에서 캡슐 눌렀을때 반대로 cid값 플러터한테 보내주고, 그 값을 토대로 캡슐 찾아서 capsuleDetail (플러터)스크린 띄우도록 해야함.

    public ARRaycastManager arRaycaster;
    public GameObject placeObject;
    // GameObject spawnObject;
    public GameObject capsule;
    private RaycastHit hitInfo;
    public float rotationSpeed = 30f;

    private ARRaycastManager arRaycastManager;
    void Start()
    {
        Debug.Log("ㅎㅇ");
         arRaycastManager = GetComponent<ARRaycastManager>();
        placeObject.SetActive(false); 
        capsuleCreate(3,"hi");
        // unityMessageReceiver = GetComponent<UnityMessageReceiver>();
        // TODO: 음 이거 캡슐 생성할때, 플러터에서 데이터베이스에 정보 요청해서 인근에 캡슐 있을 때, create 하고 그 create 따라서 정보 삽입하도록 해야할듯. 나중에는 카메라 버튼 누를때 플러터를 작동시키는게 아니라, 위치 변할때마다 작동시켜줘야지. 하아 .. 
        //TODO: 캡슐 눌렀을 때 title도 뜨게 해줘야할듯 ,detail로 cid뿐만 아니라 title도 받아와야할듯
    }

    // Update is called once per frame
    void Update()
    {
         rotate();
        // capsuleCreate(unityMessageReceiver.receivedCid);
        // PlaceObjectByTouch();
         if(Input.GetMouseButtonDown(0))
        {
            Vector3 mousePos = Input.mousePosition;
            Ray screenRay = Camera.main.ScreenPointToRay(mousePos);
            if(Physics.Raycast(screenRay.origin, screenRay.direction* 1000f, out hitInfo)){
                if(hitInfo.collider.CompareTag("capsule") ){
                    hitInfo.collider.gameObject.SetActive(false);
                    Debug.Log("capsule 터치");
                    capsule.SetActive(false);
                }}
       

        }
    }

   
    //FIXME: 이건 2d인거 같고 3로 바꿔야될거 같은데. 아 그리고 이거 레이케스트로 하지말고 그냥 생성되는 캡슐마다 각각 오브젝트 터치 감지하도록 해야될듯 ㅋㅋ 계속 레이케스트 물체 포착이 안돼

  
    private void HandleTouch()
{
    Vector2 touchPosition = Input.GetTouch(0).position;
    List<ARRaycastHit> hits = new List<ARRaycastHit>();

    if (arRaycastManager.Raycast(touchPosition, hits, UnityEngine.XR.ARSubsystems.TrackableType.PlaneWithinPolygon))
    {
        foreach (var hit in hits)
        {
            GameObject hitObject = hit.trackable.gameObject;
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
    }
    private void rotate()
    {

        if (capsule != null)
        {

            capsule.transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
        }

    }

    public void receiveMessage(string message)
    {
        Debug.Log("플러터에서 받은 cid,title 메시지:" + message);
        string[] parts = message.Split(',');
        int cid = int.Parse(parts[0]);
        string title = parts[1];
        // receivedCid = int.Parse(message);
        Debug.Log("처음이 cid 뒤가 title: " + cid + title);
        capsuleCreate(cid, title);
    }

    public void capsuleCreate(int cid, string title)
    {

        // receivedCid = cid;

        // if(Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Began)
        // {
        // 카메라의 현재 위치와 방향을 기준으로 함
        Vector3 cameraPosition = Camera.main.transform.position;
        Vector3 cameraForward = Camera.main.transform.forward;

        // 카메라로부터 일정 거리 내에서 랜덤한 위치 결정
        float distance = Random.Range(1.0f, 5.0f); // 1m에서 5m 사이의 랜덤한 거리
        // Vector3 randomDirection = Random.insideUnitSphere; // 랜덤한 방향
        // Vector3 forwardDirection = Vector3.forward; // z축으로의 단위벡터
        Vector3 spawnPosition = cameraPosition + cameraForward * distance;

        // 랜덤 위치에 오브젝트 생성
        capsule = Instantiate(placeObject, spawnPosition, Quaternion.identity);
        // Instantiate(placeObject, spawnPosition, Quaternion.identity);   
        // Instantiate(placeObject, spawnPosition, Quaternion.identity);   

        capsule.GetComponent<CapsuleDetail>().assignCid(cid);
        capsule.GetComponent<CapsuleDetail>().assignTitle(title);


        capsule.SetActive(true);

        Debug.Log(spawnPosition);
        Debug.Log("캡슐 생성 완료");
        // }
    }

    // private void PlaceObjectByTouch(){
    //     if(Input.touchCount>0){
    //         Touch touch = Input.GetTouch(0);
    //         List<ARRaycastHit> hits = new List<ARRaycastHit>();
    //         if(arRaycaster.Raycast(touch.position,hits,UnityEngine.XR.ARSubsystems.TrackableType.Planes)){
    //             Pose hitPose = hits[0].pose;
    //             if(!capsule){
    //                 //  spawnObject = Instantiate(placeObject, hitPose.position, hitPose.rotation);
    //             // 오브젝트 실사화 함수
    //             }
    //             else{
    //                 capsule.transform.position = hitPose.position;
    //                 // capsule.transform.rotation = hitPose.rotation;
    //             }

    //         }
    //     }
    // }

    // private void UpdateCenterObject(){
    //     Vector3 screenCenter = Camera.current.ViewportToScreenPoint(new Vector3(0.5f, 0.5f));
    //     List<ARRaycastHit> hits = new List<ARRaycastHit>();
    //     arRaycaster.Raycast(screenCenter, hits, UnityEngine.XR.ARSubsystems.TrackableType.Planes);

    //     if(hits.Count>0){
    //         Pose placementPose = hits[0].pose;
    //         placeObject.SetActive(true);
    //         placeObject.transform.SetPositionAndRotation(placementPose.position, placementPose.rotation);
    //     }

    //     // else{
    //     //     placeObject.SetActive(false);
    //     // }

    // }

}

