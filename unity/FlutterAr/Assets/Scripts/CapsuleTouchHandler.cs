using UnityEngine;

public class CapsuleTouchHandler : MonoBehaviour
{
    private CapsuleDetail capsuleDetail;

    void Start()
    {
        capsuleDetail = GetComponent<CapsuleDetail>();
        if (capsuleDetail == null)
        {
            Debug.LogError("CapsuleDetail component not found!");
        }
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
          if (Physics.Raycast(ray, out hit, Mathf.Infinity, LayerMask.GetMask("YourLayerName"))){
            Debug.Log("레이케스트 감지되는거 아닌듯");
          } 
        if (Physics.Raycast(ray, out hit))
        {
            Debug.Log("Raycast hit: " + hit.collider.gameObject.name);
            
            if (hit.collider != null)
            {
                if (hit.collider.gameObject == gameObject)
                {
                    Debug.Log("Touch is on the capsule!");
                    if (capsuleDetail != null)
                    {
                        int cid = capsuleDetail.getCid();
                        string title = capsuleDetail.getTitle();
                        Debug.Log($"Touched capsule with cid: {cid}, title: {title}");
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
            }
        }
        else
        {
            Debug.Log("Raycast did not hit any object.");
        }
    }
}
