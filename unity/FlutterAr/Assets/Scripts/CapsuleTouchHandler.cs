using System.Collections.Generic;
using FlutterUnityIntegration;
using Unity.VisualScripting;
using UnityEngine;

public class CapsuleTouchHandler : MonoBehaviour
{
    private CapsuleDetail capsuleDetail;
    public GameObject imagePrefab; // 이미지 프리팹
    public List<GameObject> CapsuleImageList;
    
    private int cid =  -1;
    private string title = null;

    
    void Start()
    {

        imagePrefab.SetActive(false);
        capsuleDetail = GetComponent<CapsuleDetail>();
    }

    void Update()
    {
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);
            if (touch.phase == TouchPhase.Began)
            {
                Debug.Log("Touch detected at position: " + touch.position);
                HandleTouch(touch.position);
            }
        }


    }

    private void HandleTouch(Vector2 touchPosition)
    {
        Ray ray = Camera.main.ScreenPointToRay(touchPosition);
        Debug.Log("Ray created: " + ray);

        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, Mathf.Infinity))
        {
            Debug.Log("Raycast hit: " + hit.collider.gameObject.name);

            if (hit.collider != null)
            {
                if (hit.collider.gameObject.name == "polySurface14")
                {
                    Debug.Log("Touch is on the capsule!");
                    if (capsuleDetail != null)
                    {
                        cid = capsuleDetail.getCid();
                        title = capsuleDetail.getTitle();
                        Debug.Log($"Touched capsule with cid: {cid}, title: {title}");
                        // sendToFlutter($"touchCapsule,{cid},{title}");
                        // FIXME: 이미지 보이는거 하고 나면 다시 수정해야함
                        ShowImageOnCapsule(hit.point); // 터치된 위치에 이미지 표시
                    }
                }
                else if(hit.collider.gameObject.name == "testpic"){
                    Debug.Log("Touch is on the image of capsule!");
                    sendToFlutter($"touchImage,{this.cid},{this.title}");
                }
                else
                {
                    Debug.Log("Touched a different object: " + hit.collider.gameObject.name);
                }
            }
            else
            {
                Debug.Log("Raycast hit but no collider found.");
                Debug.DrawRay(ray.origin, ray.direction * 100, Color.red, 1.0f);
            }
        }
        else
        {
            Debug.Log("Raycast did not hit any object.");
        }
    }

    private void ShowImageOnCapsule(Vector3 position)
{
    if (imagePrefab != null)
    {
        Debug.Log("Instantiating image at position: " + position);

        // Get the camera position
        Vector3 cameraPosition = Camera.main.transform.position;

        // Calculate the direction vector from the capsule (hit point) to the camera
        Vector3 directionToCamera = (cameraPosition - position).normalized;

        // Determine the distance offset from the capsule towards the camera
        float distanceFromCapsule = 1.0f; // This is the offset distance along the line, adjust as needed
        // * 위에거 수동으로 임시로 했는데, 흠 이거 자동으로 하게 해야되는데 굳이 그러지 말자 귀찮다.

        // Calculate the spawn position of the image between the capsule and the camera
        Vector3 spawnPosition = position + directionToCamera * distanceFromCapsule;

        // Instantiate the image at the calculated position
        GameObject CapsuleImage = Instantiate(imagePrefab, spawnPosition, Quaternion.identity);

        // Ensure the image faces the camera
        CapsuleImage.transform.LookAt(Camera.main.transform);

        // Optional: Set texture quality settings
        Renderer renderer = CapsuleImage.GetComponent<Renderer>();
        if (renderer != null && renderer.material != null)
        {
            renderer.material.mainTexture.filterMode = FilterMode.Trilinear;
        }

        // Add the instantiated image to the list and activate it
        CapsuleImageList.Add(CapsuleImage);
        Debug.Log("Image instantiated between the capsule and the camera at position: " + spawnPosition);
        CapsuleImage.SetActive(true);
    }
    else
    {
        Debug.Log("imagePrefab is not assigned.");
    }
}


    // todo: 받은 cid를 터치했을 때 다시 flutter한테 보내가지고, flutter한테서 해당 cid의 image를 받아야함.
    public void sendToFlutter(string message)
    {
        UnityMessageManager.Instance.SendMessageToFlutter(message);
        Debug.Log("플러터에 보내줄 cid,title 메시지:" + message);
    }


}
