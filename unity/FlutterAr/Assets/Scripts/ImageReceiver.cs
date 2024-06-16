using UnityEngine;
using UnityEngine.UI;

public class ImageReceiver : MonoBehaviour
{
    public RawImage rawImage; // Canvas의 RawImage 컴포넌트를 Inspector에서 할당

    void Start()
    {
        
    }


    void receiveImage(string message)
    {
        // Base64 문자열을 바이너리 데이터로 디코딩
        byte[] imageBytes = System.Convert.FromBase64String(message);

        // 바이너리 데이터를 Texture2D로 변환
        Texture2D receivedTexture = new Texture2D(1, 1);
        receivedTexture.LoadImage(imageBytes);

        // RawImage의 Texture를 받은 텍스처로 설정
        rawImage.texture = receivedTexture;
        rawImage.SetNativeSize(); // 원본 사이즈로 설정

        Debug.Log("Image received and displayed on RawImage in Canvas.");
    }

  
}
