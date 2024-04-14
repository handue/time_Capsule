using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class TakePhotos : MonoBehaviour
{   
    public void TakePhoto(){
        StartCoroutine(takePhoto());
    }
    IEnumerator takePhoto()
    {
         yield return new WaitForEndOfFrame();
        Camera camera = Camera.main;
        int width = Screen.width;
        int height = Screen.height;
        RenderTexture rt = new RenderTexture(width, height, 24);
        camera.targetTexture = rt ;
        // The Render Texture in RenderTexture.active is the one
        // that will be read by ReadPixels.
        var currentRT = RenderTexture.active;
        RenderTexture.active = rt;
        //렌더 텍스쳐는 유니티에서 3d 렌더링 결과를 저장하는 특별한 종류의 텍스처
        //2d 텍스처와 유사, 렌더링된 이미지를 저장하는데 사용됨
        // 이미지 저장할떄도 사용  

        // Render the camera's view.
        camera.Render();

        // Make a new texture and read the active Render Texture into it.
        Texture2D image = new Texture2D(width, height);
        image.ReadPixels(new Rect(0, 0, width, height), 0, 0);
        image.Apply();

        camera.targetTexture = null;

        // Replace the original active Render Texture.
        RenderTexture.active = currentRT;
        
        // byte[] bytes = image.EncodeToPNG();
        // string fileName = DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".png";
        // string filepath = Path.Combine(Application.persistentDataPath,fileName);
        // File.WriteAllBytes(filepath, bytes);
        
        // 이미지를 갤러리에 저장하는 함수 호출
        NativeGallery.SaveImageToGallery(image, "CapInNet", "My AR Image {0}.png", (success, path) => Debug.Log("Image saved: " + success + " to " + path));
        
        
        Destroy(rt);
        Destroy(image);
    }
}
