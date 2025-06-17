<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
            <form:form action="venue/new" method="post" modelAttribute="newVenue" class="needs-validation">
                        <div class="form-group">
                            <form:label path="name" cssClass="form-label">اسم</form:label>
                            <form:input path="name" cssClass="form-control"/>
                            <form:errors path="name" cssClass="text-danger"/>
                        </div>
                        
                        <div class="form-group">
                            <form:label path="city" cssClass="form-label">مدينة</form:label>
                            <form:input path="city" cssClass="form-control"/>
                            <form:errors path="city" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <form:label path="pricePerDay" cssClass="form-label">السعر ليوم واحد</form:label>
                            <form:input type="number"  path="pricePerDay" cssClass="form-control"/>
                            <form:errors path="pricePerDay" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <form:label path="capacity" cssClass="form-label">السعة</form:label>
                            <form:input type="number" path="capacity" cssClass="form-control"/>
                            <form:errors path="capacity" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <form:label path="description" cssClass="form-label">التفاصيل</form:label>
                            <form:input path="description" cssClass="form-control"/>
                            <form:errors path="description" cssClass="text-danger"/>
                        </div>
                        
                        <div class="form-group">
    						<label for="fileInput">Upload Image</label>
    						<input type="file" id="fileInput" class="form-control">
    						<small id="uploadStatus" class="text-muted"></small>
						</div>
                        
                        <form:input path="imageUrl" cssClass="form-control" id="imageUrl" type="hidden" />
                        
                        <img id="imagePreview" src="" alt="Image Preview" style="max-width:200px; display:none;" />
                        
               

                        <div class="text-right">
                            <button type="submit" class="btn btn-success">انشاء</button>
                        </div>
                        </form:form>
                        
                        <div class="form-group">
    <label>Image Preview</label>
    <img id="previewImage" src="" alt="Image will appear here" style="max-width: 300px; display: none;" />
</div>
                        
                        
                        <script>
document.getElementById("fileInput").addEventListener("change", function () {
    const file = this.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    const status = document.getElementById("uploadStatus");
    status.textContent = "Uploading...";

    fetch("/upload", {
        method: "POST",
        body: formData
    })
    .then(response => response.text())
.then(url => {
    document.getElementById("imageUrl").value = url;
    const preview = document.getElementById("imagePreview");
    preview.src = url;
    preview.style.display = 'block';
    status.textContent = "Image uploaded successfully.";
})

    .catch(error => {
        console.error("Upload failed:", error);
        status.textContent = "Failed to upload image.";
    });
    
});
</script>
                        

</body>
</html>