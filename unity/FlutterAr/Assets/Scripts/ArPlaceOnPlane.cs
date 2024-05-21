
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

// using UnityEngine.Android;

public class ArPlaceOnPlane : MonoBehaviour
{

    // TODO: 5월15일에 해야할거, 이제 유니티에서 캡슐 눌렀을때 반대로 cid값 플러터한테 보내주고, 그 값을 토대로 캡슐 찾아서 capsuleDetail (플러터)스크린 띄우도록 해야함.

    public ARRaycastManager arRaycastManager;
    public GameObject placeObject;
    public GameObject capsulePrefab;
    public float rotationSpeed = 30f;
    private List<GameObject> spawnedCapsules = new List<GameObject>();

    void Start()
    {
       Debug.Log("ㅎㅇ");
        arRaycastManager = FindObjectOfType<ARRaycastManager>();
        if (arRaycastManager == null)
        {
            Debug.LogError("ARRaycastManager is null. Please assign a valid ARRaycastManager component.");
        }
        placeObject.SetActive(false);
        // capsuleCreate(3,"hi");
        // unityMessageReceiver = GetComponent<UnityMessageReceiver>();
        // TODO: 음 이거 캡슐 생성할때, 플러터에서 데이터베이스에 정보 요청해서 인근에 캡슐 있을 때, create 하고 그 create 따라서 정보 삽입하도록 해야할듯. 나중에는 카메라 버튼 누를때 플러터를 작동시키는게 아니라, 위치 변할때마다 작동시켜줘야지. 하아 .. 
        //TODO: 캡슐 눌렀을 때 title도 뜨게 해줘야할듯 ,detail로 cid뿐만 아니라 title도 받아와야할듯
    }

    // Update is called once per frame
    void Update()
    {
         RotateCapsules();
          Debug.Log("arRaycastManager: " + arRaycastManager);

         if(Input.touchCount> 0 && Input.GetTouch(0).phase== TouchPhase.Began){
            HandleTouch(Input.GetTouch(0).position);
         }
   
    }

   
    //FIXME: 이건 2d인거 같고 3로 바꿔야될거 같은데. 아 그리고 이거 레이케스트로 하지말고 그냥 생성되는 캡슐마다 각각 오브젝트 터치 감지하도록 해야될듯 ㅋㅋ 계속 레이케스트 물체 포착이 안돼

  
    private void HandleTouch(Vector2 touchPosition)
{
    
    Debug.Log("touchPosition: "  + touchPosition);
    List<ARRaycastHit> hits = new List<ARRaycastHit>();

    if (arRaycastManager.Raycast(touchPosition, hits, TrackableType.PlaneWithinBounds))
        {
            foreach (var hit in hits)
            {
                Pose hitPose = hit.pose;
                GameObject hitObject = null;

                foreach (var capsule in spawnedCapsules)
                {
                    if (Vector3.Distance(capsule.transform.position, hitPose.position) < 0.1f) // Adjust the distance threshold as needed
                    {
                        hitObject = capsule;
                        break;
                    }
                }

                if (hitObject != null)
                {
                    CapsuleDetail capsuleDetail = hitObject.GetComponent<CapsuleDetail>();
                    if (capsuleDetail != null)
                    {
                        int cid = capsuleDetail.cid;
                        string title = capsuleDetail.title;
                        Debug.Log($"Touched capsule with cid: {cid}, title: {title}");
                        // Handle the touch event, e.g., send data to Flutter
                    }
                }
            }
        }
    }
    private void RotateCapsules()
    {
        foreach (var capsule in spawnedCapsules)
        {
            if (capsule != null)
            {
                capsule.transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
            }
        }

        // if (capsule != null)
        // {

        //     capsule.transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
        // }

    }

       public void ReceiveMessage(string message)
    {
        Debug.Log("플러터에서 받은 cid,title 메시지:" + message);
        string[] parts = message.Split(',');
        int cid = int.Parse(parts[0]);
        string title = parts[1];
        Debug.Log("처음이 cid 뒤가 title: " + cid + title);
        CapsuleCreate(cid, title);
    }

    public void CapsuleCreate(int cid, string title)
    {
        Vector3 cameraPosition = Camera.main.transform.position;
        Vector3 cameraForward = Camera.main.transform.forward;
        float distance = Random.Range(1.0f, 5.0f);
        Vector3 spawnPosition = cameraPosition + cameraForward * distance;

        GameObject newCapsule = Instantiate(capsulePrefab, spawnPosition, Quaternion.identity);
        CapsuleDetail capsuleDetail = newCapsule.GetComponent<CapsuleDetail>();
        capsuleDetail.assignCid(cid);
        capsuleDetail.assignTitle(title);

        spawnedCapsules.Add(newCapsule);
        newCapsule.SetActive(true);

        Debug.Log($"Capsule created at: {spawnPosition} with cid: {cid}, title: {title}");
    }
}

//TODO: 그냥 실행 돌려보면 됨 다시 오면 ..

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



