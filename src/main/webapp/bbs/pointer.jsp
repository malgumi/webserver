<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
      <img id="img1" style="position:absolute; left:0; top:0; z-index:999;" src="pointer.png" height=80px;>
 
<script>

    var mouseX = 0;
    var mouseY = 0; 
 
    function getMousePosition(e){
        var eObj = window.event? window.event : e; // IE, FF �� ���� �̺�Ʈ ó�� �ϱ�
        mouseX = eObj.clientX;
        mouseY = eObj.clientY + document.documentElement.scrollTop; // ȭ���� ��ũ�� �������� ���� ó�� (��ũ�� �� ��ŭ ���콺 Y��ǥ�� + )
        // documentElement �� �ȵȴٸ� body �ٲ�� �Ѵ�. ũ���� ���.. (�ڵ��ľ� ���� �ʿ�)
    }
 
    function moveImg(){
        // �̹��� ��ġ �ľ��ϱ�
        var m_x = parseInt(document.getElementById('img1').style.left.replace('px', ''));
        var m_y = parseInt(document.getElementById('img1').style.top.replace('px', ''));
 
        // �̹��� �����̱�
        document.getElementById('img1').style.left = Math.round(m_x + ((mouseX - m_x) / 3)) + 'px';
        document.getElementById('img1').style.top = Math.round(m_y + ((mouseY - m_y) / 3)) + 'px';
 
        // �ε巴�� ������� ���� �뷫..
        // ���� �̹�����ġ = �����̹��� ��ġ + (�̹��� ��ġ���� ���콺 Ŀ�� ��ġ / ������ ������ ��)
        // �ݺ� ó�� ���ָ� �˴ϴ�.
         
        // �� �̹��� ��ġ ���� ���콺 Ŀ�� ��ġ��?
        // �̹����� �������� �� �̹������� Ŀ���� �󸶳� ������ �ִ��� ����
    }
 
    document.onmousemove = getMousePosition; // ���콺�� �����̸� getMousePosition �Լ� ����
    setInterval("moveImg()", 50); // moveImg �Լ� �ݺ� �����Ͽ� �̹��� �����̱�
</script>
</body>
</html>