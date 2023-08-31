from django.shortcuts import render
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import TodolistSerializer
from .models import Todolist

#GET Data
@api_view(['GET'])
def all_todolist(request):
    alltodolist = Todolist.objects.all()# ດືງຂໍ້ມູນຈາກ model Todolist ຖ້າໃຊ້ໃນຄຳສັ່ງ sql ຈະໄດ້ serect * from table
    serializer = TodolistSerializer(alltodolist,many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

# POST Data (save data to database)
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializer = TodolistSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_todolist(request,TID):
    # ສົມມຸດວ່າ TID = 13
    # localhost:8000/api/update-todolist/13 
    todo = Todolist.objects.get(id=TID)

    if request.method =='PUT':
        data = {} #ກຳນົດຕົວເເປເປັນ dictionary
        serializer = TodolistSerializer(todo,data=request.data)
        if serializer.is_valid():
            serializer.save()
            data ['status'] = 'updated' #ຈະເປັນການເພີ່ມຂໍ້ມູນໃໝ່ໃຫ້ dictionary ທີມີ key = 'status' & value = 'updated'
            return Response(data=data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_todolist(request, TID):
    todo = Todolist.objects.get(id=TID)
    if request.method == 'DELETE':
        data = {}
        delete = todo.delete()
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        return Response(data=data, status=statuscode)

data = [
    {
        "title":"คอมพิวเตอร์คืออะไร?",
        "subtitle":"คอมพิวเตอร์ คือ อุปกรณ์ที่ใช้สำหรับการคำนวณและทำงานอื่นๆ?",
        "image_url":"https://raw.githubusercontent.com/PernG20/BasicAPI/main/computer.jpg?token=GHSAT0AAAAAAB5ECBIOHLZG6G4QFV4XXZRKY562GSA",
        "detail":"dfdf"
    },
    {
        "title":"มาเขียนโปรแกรมกัน!",
        "subtitle":"บทความนี้จะแนะนำการเริ่มต้นเขียนโปรแกรม",
        "image_url":"https://raw.githubusercontent.com/PernG20/BasicAPI/main/programlg.jpg?token=GHSAT0AAAAAAB5ECBIPKHQ2ZUFPOUJRJAPCY562IDA",
        "detail":"dsf"
    },
    {
        "title":"Flutter คือ?",
        "subtitle":"Tools สำหรับออกแบบ UI ของ Google",
        "image_url":"https://raw.githubusercontent.com/PernG20/BasicAPI/main/flutterlogo.jpg?token=GHSAT0AAAAAAB5ECBIPZEELWD3X3D6GO6S2Y562I6Q",
        "detail":"ssss"
    },
    {
        "title" : "Dart ຄື​?",
        "subtitle":"ภาษาเขียนโปรแกรมชนิดหนึ่ง สร้างขึ้นเมื่อ 2019",
        "image_url" : "https://raw.githubusercontent.com/PernG20/BasicAPI/main/dart-logo.jpg?token=GHSAT0AAAAAAB5ECBIOZRRJMIVMIVZ5VAJGY562JRA",
        "detail" : "__OPO"
    }

]


def Home(request):
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii': False})
