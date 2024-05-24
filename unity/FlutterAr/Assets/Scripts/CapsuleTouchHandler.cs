using FlutterUnityIntegration;
using UnityEngine;

public class CapsuleTouchHandler : MonoBehaviour
{
    private CapsuleDetail capsuleDetail;

    void Start()
    {
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

            // Debug.DrawLine(ray.origin, hit.point, Color.green, 1.0f);

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
                        sendToFlutter($"touchCapsule,{cid},{title}");
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

        // Visual aid for debugging in the scene view
        // Debug.DrawRay(ray.origin, ray.direction * 100, Color.red, 2f);
    }

        public void sendToFlutter(string message){
        UnityMessageManager.Instance.SendMessageToFlutter(message);
        // TODO: 캡슐 터치했으니까, cid랑 title 정보 다시 넘겨줘서 그 넘겨준 정보 토대로 플러터에서 캡슐창 열도록 해야함.
        // FIXME: 이제 음 .. 캡슐 위에다가 title 푯말 뜨게 해줘야함.
        Debug.Log("플러터에 보내줄 cid,title 메시지:" + message);
        // string[] parts = message.Split(',');
        // int cid = int.Parse(parts[0]);
        // string title = parts[1];
        // receivedCid = int.Parse(message);

       
    }
}