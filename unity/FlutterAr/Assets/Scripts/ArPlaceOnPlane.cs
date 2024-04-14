using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.XR.ARFoundation;


public class ArPlaceOnPlane : MonoBehaviour
{   

    

    public ARRaycastManager arRaycaster;
    public GameObject placeObject;
    GameObject spawnObject;
    public GameObject capsule;

    public List<GameObject> capsuleList = new List<GameObject>();

    public float rotationSpeed = 30f;
    // Start is called before the first frame update
    void Start()
    {  
       
        placeObject.SetActive(false);
        capsuleCreate();
        
    
    }

    // Update is called once per frame
    void Update()
    {   
        // PlaceObjectByTouch();
        rotate();
      
    }

    private void rotate(){

        if(capsule!= null){
            
             capsule.transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
        }
        
    }


    private void capsuleCreate(){
        // if(Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Began)
    // {
        // 카메라의 현재 위치와 방향을 기준으로 함
        Vector3 cameraPosition = Camera.main.transform.position;
        Vector3 cameraForward = Camera.main.transform.forward;
        
        // 카메라로부터 일정 거리 내에서 랜덤한 위치 결정
        float distance = Random.Range(1.0f, 5.0f); // 1m에서 3m 사이의 랜덤한 거리
        // Vector3 randomDirection = Random.insideUnitSphere; // 랜덤한 방향
        // Vector3 forwardDirection = Vector3.forward; // z축으로의 단위벡터
        Vector3 spawnPosition = cameraPosition + cameraForward * distance;
        
        // 랜덤 위치에 오브젝트 생성
        capsule = Instantiate(placeObject, spawnPosition, Quaternion.identity);   
        // Instantiate(placeObject, spawnPosition, Quaternion.identity);   
        // Instantiate(placeObject, spawnPosition, Quaternion.identity);   
        
        capsule.SetActive(true); 
        Debug.Log(spawnPosition);    
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
