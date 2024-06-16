using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

public class ArPlaceImageOnPlane : MonoBehaviour
{
    private ARRaycastManager arRaycastManager;
    public GameObject imagePrefab; // 이미지 프리팹
    private GameObject spawnedImage;
    private List<ARRaycastHit> hits = new List<ARRaycastHit>();

    void Start()
    {
        arRaycastManager = GetComponent<ARRaycastManager>();
    }

    void Update()
    {
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {
                if (arRaycastManager.Raycast(touch.position, hits, TrackableType.PlaneWithinPolygon))
                {
                    Pose hitPose = hits[0].pose;

                    if (spawnedImage == null)
                    {
                        spawnedImage = Instantiate(imagePrefab, hitPose.position, hitPose.rotation);
                    }
                    else
                    {
                        spawnedImage.transform.position = hitPose.position;
                    }
                }
            }
        }
    }
}
