<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CSR</title>
<style>
.container {
	text-align: center;
	padding: 20px 25px;
}
table {
	margin: 20px auto;
}
</style>
</head>
<body>
<jsp:include page="/fragment/top.jsp" />
<div class=container>
	<form name="order2" action="<c:url value='/_04_ST/04_Booking2.jsp'/> " method="get">
<%-- <c:set var="add" value="${param.add}" scope="session"/>  --%>
    <H1>預約場次明細</H1>
      <table border="1">    
        <tr>
            <td class="title">節目名稱</td>
            <td>票種</td>
            <td>數量</td>
            <td>價格</td>
            <td class="price2">總價</td>
        </tr>   
        <%--使用JSTL 執行for loop ${show.no}取map內value --%>
        <c:forEach items="${cartlist}" var="show" varStatus="idx">
        <tr>
       <!-- 傳送訂單資訊 -->
       <form name="order" action="" method="get">
		<tr>
            <td>${show.title}</td>
            <td>全票</td>
             <td>
                <input type="button" value="-" name="minus" class="minus" id="minus">
                <input type="text" name="adultnum" id="adultnum" class="adultnum" value="${show.adultnum}" >
                <input type="button" value="+" name="plus" class="plus" id="plus">
            </td>
           <td name="price" class="price" id="price" >NT$1000</td>
            <td>NT$<input type="text" name="total1" id="total1" class="total1"value="${show.total1}" readonly="readonly" /></td>
         </tr>
         <tr>
            <td>${show.title}</td>
            <td>半票</td>
            <td>
                <input type="button" value="-" name="minus2" class="minus2" id="minus2">
                <!-- <P name="orderNum" id="orderNum" class="orderNum"></P> -->
                <input type="text" name="halfnum" id="halfnum" class="halfnum" value="${show.halfnum}" >
                <input type="button" value="+" name="plus2" class="plus2" id="plus2">
            </td>
            
            <td name="price" class="price" id="price" >NT$500</td>
            <td>NT$<input type="text" name="total2" id="total2" class="total2"value="${show.total2}" readonly="readonly" /></td>

        </tr>
			</form>
			
	<!-- 		設定totalprice加總 -->
		<c:set var="sum" value="${sum + show.totalprice}" />		
		</c:forEach>
<tr><td>總計</td><td></td><td></td><td></td><td>NT$<input type="text" name="total3" id="total3" class="totalprice"value="${sum}" readonly="readonly" /></td><tr>
   </table>     
          <input type="submit" value="繼續購票" name="1" class="1" id="1">  
          </form> 
   		<form name="order" action="<c:url value='/_04_ShopCart/ClearCart'/>" method="POST">
          <input type="submit" value="全部清除" name="clear" class="clear" id="clear"> 
    	 </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
        //全票
        $(document).ready(function(){
 
        $("#adultnum").val(count);
        $(".plus").click(function () {
        	//設定數量上限為5
        	if (count < 5) {
        		count++;
            } else if (count=5 ) {
            	count = 5;
            	alert("最多訂購五張");
            }
        $(".adultnum").val(count);
        $(".total1").val(count*parseInt(1000))
        $("#total3").val(count*parseInt(1000)+count2*parseInt(500))
        }) 
        $("#minus").click(function () {
        	//設定數量下限0
        	if (count >0) {
        		count--;
            } else if (count=0 ) {
            	count = 0;
            }
        $("#adultnum").val(count);
        $("#total1").val(count*parseInt(1000))
		$("#total3").val(count*parseInt(1000)+count2*parseInt(500))
        return count;
        }) 
 
        $("#halfnum").val(count2);
        $("#plus2").click(function () {
        	if (count2 < 5) {
        		count2++;
            } else if (count2=5 ) {
            	count2 = 5;
            	alert("最多訂購五張");
            }
        $("#halfnum").val(count2);  
        $("#total2").val(count2*parseInt(500))
       	$("#total3").val(count*parseInt(1000)+count2*parseInt(500))
        }) 
        $("#minus2").click(function () {
        	if (count2 >0) {
        		count2--;
            } else if (count2=0 ) {
            	count2 = 0;
            }
        $("#halfnum").val(count2);
        $("#total2").val(count2*parseInt(500)) 
        $("#total3").val(count*parseInt(1000)+count2*parseInt(500))
        }) 

    }) 
</script>

</body>
</html>