
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using TMPro;

public class ArPlaceOnPlane : MonoBehaviour
{
    // TODO: 5월15일에 해야할거, 이제 유니티에서 캡슐 눌렀을때 반대로 cid값 플러터한테 보내주고, 그 값을 토대로 캡슐 찾아서 capsuleDetail (플러터)스크린 띄우도록 해야함.
    private ARRaycastManager arRaycastManager;
    public GameObject placeObject;
    // GameObject spawnObject;
    public GameObject capsule;
    public GameObject textGameObject;
    public GameObject textPrefab;
    public float rotationSpeed = 30f;
    private List<GameObject> textObjects = new List<GameObject>();

    public List<GameObject> spawnedCapsules = new List<GameObject>();

    void Start()
    {
        // capsuleCreate(12,"test");
        placeObject.SetActive(false);
        textGameObject.SetActive(false);
        // capsuleCreate(3,"hi");
        // unityMessageReceiver = GetComponent<UnityMessageReceiver>();
        // TODO: 음 이거 캡슐 생성할때, 플러터에서 데이터베이스에 정보 요청해서 인근에 캡슐 있을 때, create 하고 그 create 따라서 정보 삽입하도록 해야할듯. 나중에는 카메라 버튼 누를때 플러터를 작동시키는게 아니라, 위치 변할때마다 작동시켜줘야지. 하아 .. 
        //TODO: 캡슐 눌렀을 때 title도 뜨게 해줘야할듯 ,detail로 cid뿐만 아니라 title도 받아와야할듯
    }


    void Update()
    {
        if (spawnedCapsules.Count > 0)
        {
            foreach (GameObject capsule in spawnedCapsules)
            {
                if (capsule != null)
                {
                    capsule.transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
                }
            }
        }

        // if (textObjects.Count > 0)
        // {
        //     foreach (GameObject textObj in textObjects)
        //     {
        //         if (textObj != null)
        //         {
        //             textObj.transform.rotation = Quaternion.identity;
        //         }
        //     }
        // }
        // ! 그냥 같이 회전시키는게 보기 더 좋은거 같음


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
        string image = parts[2];
        // receivedCid = int.Parse(message);
        Debug.Log("처음이 cid 뒤가 title, 맨 마지막이 이미지: " + cid + title + image);
        capsuleCreate(cid, title);
    }

    public void capsuleCreate(int cid, string title)
    {


        // 카메라의 현재 위치와 방향을 기준으로 함
        Vector3 cameraPosition = Camera.main.transform.position;
        Vector3 cameraForward = Camera.main.transform.forward;

        // 카메라로부터 일정 거리 내에서 랜덤한 위치 결정
        float distance = Random.Range(4.0f, 8.0f); // 1m에서 5m 사이의 랜덤한 거리
        // Vector3 randomDirection = Random.insideUnitSphere; // 랜덤한 방향
        // Vector3 forwardDirection = Vector3.forward; // z축으로의 단위벡터
        Vector3 spawnPosition = cameraPosition + cameraForward * distance;

        // 랜덤 위치에 오브젝트 생성
        capsule = Instantiate(placeObject, spawnPosition, Quaternion.identity);

        // Instantiate(placeObject, spawnPosition, Quaternion.identity);   
        // Instantiate(placeObject, spawnPosition, Quaternion.identity);   

        capsule.GetComponent<CapsuleDetail>().assignCid(cid);
        capsule.GetComponent<CapsuleDetail>().assignTitle(title);
        spawnedCapsules.Add(capsule);

        capsule.SetActive(true);


        GameObject newTextObject = Instantiate(textPrefab, capsule.transform);
        // newTextObject.GetComponent<TextMeshPro>().text = title;
        // newTextObject.SetActive(true);

        TextMeshPro textMeshPro = newTextObject.GetComponent<TextMeshPro>();
        textMeshPro.text = title;
        textMeshPro.alignment = TextAlignmentOptions.Center; // Center horizontally
        textMeshPro.alignment = textMeshPro.alignment | TextAlignmentOptions.Center; // Center vertically as well
        newTextObject.transform.localPosition = Vector3.up * 5.0f;
        newTextObject.SetActive(true);

                // todo: 백그라운드나 말풍선 같은 귀찮은거 말고, 눌렀을 떄 사진 AR로 보이도록 하는거 하자.
        

        textObjects.Add(newTextObject);

        Debug.Log(spawnPosition);
        Debug.Log("캡슐 생성 완료:" + capsule);
        // }
    }



}