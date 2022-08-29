# Hos head nurse windows desktop

โปรเจคจบ ของพยาบาล

## รายระเอียด

ความหมายของเครื่องหมาย

- :heavy_check_mark: คือ ทำเเล้ว
- :x: คือ ยังไม่ได้ทำเเละจำเป็นต้องทำ
- :warning: คือ ยังไม่ได้ทำและไม่จำเป็นต้องทำตอนนี้
- :hourglass:  คือ กำลังทำ

# Version

v 1.0 

- แสดงกลุ่มทั้งหมด เช่น จำนวนกลุ่ม ชื่อกลุ่ม
- แสดงสมาชิกภายในกลุ่ม และแสดงหัวหน้ากลุ่ม กลุ่มนั้น
- ค้นหาสมาชิกภายในโรงพยาบาล
- เพิ่มสมาชิกในกลุ่ม
- สร้างกลุ่ม
- แสดงข้อมูลของพยาบาลในหน้าจัดตารางเวร
- แสดงสีของแต่ละเวร
- แสดงข้อมูลเวรของแต่ละวันที่
- จัดการเวรของพยาบาล
- เมื่อแก้ไขตารางเวรของพยาบาลจะถูกบันทึกลงในเครื่อง
- สามารถกดเพยเพร่ของตารางเวรที่แก้ไขได้
- ล็อกอินได้
- สมัครสมาชิกได้
- ล็อกเอาท์ได้
- *(กำลังทำการล้างการแก้ไข)*
- *(ลบสมาชิกกำลังทำ)*

v 2.0 
- ลบสมาชิกในกลุ่มได้
- แก้ ui ตัว tabarด้านล่างให้สวยขึ้น
- ลบตัว ลบสมาชิกออกจากไฟล์ api_calls.dart เปลี่ยน past แจ้งเตือนใหม่ และ แก้จากput เป็น post
- แก้ ui calendar ให้สวยขึ้น
- แก้ calendar ให้สามารถ เปลียบเทียบการแลกเวรได้หรือใส่ mark ได้ 3 ที่ และเพิ่มพารามิดเตอร์ ใส่อีกคนที่แลกเวรได้
- หน้า กลุ่มสามารถลบสมาชิกได้แล้ว
- มีเช็คว่าเป็นพยาบาลหรือไม่ ป้องกันกรณีที่ไม่เป็นพยาบาลได้แล้ว
- แก้ calendar daysOfWeekHeight
- หน้าจัดตาราง แก้ ui เพิ่มปุ่ม และสามารถกดบันทึกได้
- หน้าตารางเวร แก้ ui

v 2.1
- อัพ README.md