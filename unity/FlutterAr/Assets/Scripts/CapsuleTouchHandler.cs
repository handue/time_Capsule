using System.Collections.Generic;
using FlutterUnityIntegration;
using Unity.VisualScripting;
using UnityEngine;

public class CapsuleTouchHandler : MonoBehaviour
{
    private CapsuleDetail capsuleDetail;
    public GameObject imagePrefab; // 이미지 프리팹
    public List<GameObject> CapsuleImageList;
  

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
                        int cid = capsuleDetail.getCid();
                        string title = capsuleDetail.getTitle();
                        Debug.Log($"Touched capsule with cid: {cid}, title: {title}");
                        // sendToFlutter($"touchCapsule,{cid},{title}");
                        // FIXME: 이미지 보이는거 하고 나면 다시 수정해야함
                        ShowImageOnCapsule(hit.point); // 터치된 위치에 이미지 표시
                    }
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
        // todo: 터치시에 캡슐 작동하도록 해야함 -> 터치시에 이미지 보이도록 해놓긴 함 6월17일 
        // todo: 터치 됐을 때, 이미지 가져와서 List에 넣어주고 생성되도록 해야할듯. -> 원래는 터치 되면 거기서 보낸 cid, title, image 를 리스트에 담아둬서 cid에 맞게 그 image를 가져오도록 해야하는데 일단은 테스트 용도 위해서 따로 image 보내놓도록 했음.
        // todo: 그리고 이제 이미지를 내가 직접 가져오는거 말고 터치 했을 때 flutter로부터 image 값 받아와서 출력되도록 해야함  -> 이거 해야함
        // todo: 그리고 이미지 화소? 조절할 수 있으면 하는게 나을듯 -> 터치시에 이미지 보이도록 해놓긴 함 6월16일. 아래 필터 설정해서 했음 
        if (imagePrefab != null)
        {
            Debug.Log("Instantiating image at position: " + position);

            // 카메라 위치를 기준으로 일정 거리 떨어진 위치에 이미지 생성
            Vector3 cameraPosition = Camera.main.transform.position;
            Vector3 direction = (position - cameraPosition).normalized;
            float distanceFromCamera = 4.0f; // 카메라로부터 떨어진 거리 (미터 단위로 조정 가능)
            Vector3 spawnPosition = cameraPosition + direction * distanceFromCamera;

            GameObject CapsuleImage = Instantiate(imagePrefab, spawnPosition, Quaternion.identity);

            Renderer renderer = CapsuleImage.GetComponent<Renderer>();
            if (renderer != null && renderer.material != null)
            {
                renderer.material.mainTexture.filterMode = FilterMode.Trilinear; // Trilinear 필터링 모드 설정 -> 화질 좋아지게 하려구
            }


            CapsuleImage.transform.LookAt(Camera.main.transform); // 카메라를 바라보도록 설정
            CapsuleImageList.Add(CapsuleImage);
            Debug.Log("Image instantiated and oriented towards the camera at position: " + spawnPosition);
            CapsuleImage.SetActive(true);
        }
        else
        {
            Debug.Log("imagePrefab is not assigned.");
        }
    }

    //   if (imagePrefab != null)
    //     {
    //         Debug.Log("Instantiating image at position: " + position);
    //         GameObject imageInstance = Instantiate(imagePrefab, position, Quaternion.identity);
    //         imageInstance.transform.LookAt(Camera.main.transform); // 카메라를 바라보도록 설정
    //         Debug.Log("Image instantiated and oriented towards the camera.");
    //     }
    //     else
    //     {
    //         Debug.Log("imagePrefab is not assigned.");
    //     }

    // todo: 받은 cid를 터치했을 때 다시 flutter한테 보내가지고, flutter한테서 해당 cid의 image를 받아야함.
    public void sendToFlutter(string message)
    {
        UnityMessageManager.Instance.SendMessageToFlutter(message);
        Debug.Log("플러터에 보내줄 cid,title 메시지:" + message);
    }


}
