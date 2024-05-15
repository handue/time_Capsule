using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using System.Linq;
using UnityEngine.Android;

public class ArPlaceOnPlane : MonoBehaviour
{   

    // TODO: 5월15일에 해야할거, 이제 유니티에서 캡슐 눌렀을때 반대로 cid값 플러터한테 보내주고, 그 값을 토대로 캡슐 찾아서 capsuleDetail (플러터)스크린 띄우도록 해야함.

    public ARRaycastManager arRaycaster;
    public GameObject placeObject;
    // GameObject spawnObject;
    public GameObject capsule;

    public List<GameObject> capsuleList = new List<GameObject>();

    public float rotationSpeed = 30f;
    
    UnityMessageReceiver unityMessageReceiver;
    // private int receivedCid;
    // Start is called before the first frame update
    
    private int receivedCid;
    void Start()
    {  
        
        placeObject.SetActive(false);
        // unityMessageReceiver = GetComponent<UnityMessageReceiver>();
        // TODO: 음 이거 캡슐 생성할때, 플러터에서 데이터베이스에 정보 요청해서 인근에 캡슐 있을 때, create 하고 그 create 따라서 정보 삽입하도록 해야할듯. 나중에는 카메라 버튼 누를때 플러터를 작동시키는게 아니라, 위치 변할때마다 작동시켜줘야지. 하아 .. 
        //TODO: 캡슐 눌렀을 때 title도 뜨게 해줘야할듯 ,detail로 cid뿐만 아니라 title도 받아와야할듯
    }

    // Update is called once per frame
    void Update()
    {   
        // capsuleCreate(unityMessageReceiver.receivedCid);
        // PlaceObjectByTouch();
        rotate();
      
    }

    private void rotate(){

        if(capsule!= null){
            
             capsule.transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
        }
        
    }

    public void receiveMessage(string message){
        Debug.Log("플러터에서 받은 cid,title 메시지:" + message);
        string[] parts = message.Split(',');
        int cid = int.Parse(parts[0]);
        string title = parts[1];
        // receivedCid = int.Parse(message);
        Debug.Log("처음이 cid 뒤가 title: "+cid+title);
        capsuleCreate(cid, title);
    }

    // public void receiveTitleMessage(string message){
    //         Debug.Log("플러터에서 받은 title 메시지:" + message);
    //         receiveTitleMessage = message;
    //         Debug.Log(receiveTitleMessage);
            
    // }

    public void capsuleCreate(int cid, string title){
        
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

