-- Bài 1: Tạo cơ sở dữ liệu.

create database QUANLYDIEMTHI;
use QUANLYDIEMTHI;

create table STUDENT(
studentId varchar(4) primary key,
studentName varchar(100),
birthday date,	
gender bit(1),
address text,
phoneNumber varchar(45) not null
);
alter table STUDENT
add constraint unique_phoneNumber unique (phoneNumber);

create table SUBJECT(
subjectId varchar(4) primary key,
subjectName varchar(45),
priority int(11)
);

create table MARK(
subjectId varchar(4),
studentId varchar(4),
foreign key(subjectId) references SUBJECT (subjectId),
foreign key(studentId) references STUDENT (studentId),
point int(11)
);
drop table MARK;
ALTER TABLE MARK
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY,
ADD COLUMN studentName VARCHAR(100),
ADD COLUMN math INT,
ADD COLUMN physics INT,
ADD COLUMN chemistry INT,
ADD COLUMN literature INT,
ADD COLUMN english INT;


-- Bài 2: Thêm, sửa, xóa dữ liệu.

-- Bài 2.1: Thêm dữ liệu vào các bảng.

-- Bảng STUDENT:
insert into STUDENT(studentId, studentName, birthday, gender, address, phoneNumber) values
("S001", "Nguyễn Thế Anh", 11/1/1999, 1, "Hà Nội", "984678082"),
("S002", "Đặng Bảo Trâm", 22/12/1998, 0, "Lào Cai", "904982654"),
("S003", "Trần Hà Phương", 5/5/2000, 0, "Nghệ An", "947645363"),
("S004", "Đỗ Tiến Mạnh", 26/3/1999, 1, "Hà Nội", "983665353"),
("S005", "Phạm Duy Nhất", 4/10/1998, 1, "Tuyên Quang", "987242678"),
("S006", "Mai Văn Thái", 22/6/2002, 1, "Nam Định", "982654268"),
("S007", "Giang Gia Hân", 10/11/1996, 0, "Phú Thọ", "982364753"),
("S008", "Nguyễn Ngọc Bảo My", 22/1/1999, 0, "Hà Nam", "927867453"),
("S009", "Nguyễn Tiến Đạt", 7/8/1998, 1, "Tuyên Quang", "989274673"),
("S010", "Nguyễn Thiếu Quang", 18/9/2000, 1, "Hà Nội", "984378291");
-- Lưu ý: Với 1 là Nam với 0 là Nữ.

-- Bảng SUBJECT:
insert into SUBJECT(subjectId, subjectName, priority) values
("MH01", "Toán", 2),
("MH02", "Vật Lý", 2),
("MH03", "Hóa Học", 1),
("MH04", "Ngữ Văn", 1),
("MH05", "Tiếng Anh", 2);

-- Bảng MARK:
insert into MARK(studentName, math, physics, chemistry, literature, english) values
("Nguyễn Thế Anh", 8.5, 7, 9, 9, 5),
("Đặng Bảo Trâm", 9, 8, 6.5, 8, 6),
("Trần Hà Phương", 7.5, 6.5, 8, 7, 7),
("Đỗ Tiến Mạnh", 6, 7, 5, 6.5, 8),
("Phạm Duy Nhất", 5.5, 8, 7.5, 8.5, 9),
("Mai Văn Thái", 8, 10, 9, 7.5, 6.5),
("Giang Gia Hân", 9.5, 9, 6, 9, 4),
("Nguyễn NGọc Bảo My", 10, 8.5, 8.5, 6, 9.5),
("Nguyễn Tiến Đạt", 7.5, 7, 9, 5, 10),
("Nguyễn Thiều Quang", 6.5, 8, 5.5, 4, 7);

-- Bài 2.2: Cập nhật dữ liệu.
-- Sửa tên sinh viên có mã "S004" thành "Đỗ Đức Mạnh".
-- Cập nhật tên sinh viên từ "Đỗ Tiến Mạnh" thành "Đỗ Đức Mạnh"
update STUDENT
set studentName = 'Đỗ Đức Mạnh'
where studentId = 'S004';
-- Sửa tên hệ số môn học có mã "MH05" thành Ngoại Ngữ và hệ số là 1.
-- Cập nhật tên và hệ số của môn học có mã "MH05"
update SUBJECT
set subjectName = 'Ngoại Ngữ', priority = 1
where subjectId = 'MH05';
-- Cập nhật lại điểm của học sinh có mã "S009" thành (MH01: 8.5, MH02: 7, MH03: 5.5, MH04: 6, MH05: 9).
update MARK
set point = case 
    when subjectId = 'MH01' then 8.5
    when subjectId = 'MH02' then 7
    when subjectId = 'MH03' then 5.5
    when subjectId = 'MH04' then 6
    when subjectId = 'MH05' then 9
end
where studentId = 'S009';

-- Bài 2.3: Xóa dữ liệu: 
--  Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.
-- Bảng MARK:
delete from MARK
where studentId = 'S010';
-- Bảng STUDENT:
delete from STUDENT
where studentId = 'S010';

-- Bài 3: Truy vấn dữ liệu:

-- Bài 3.1: Lấy ra tất cả thông tin của sinh viên trong bảng Student.
select * from STUDENT;

-- Bài 3.2: Hiển thị tên và mã môn học của những môn có hệ số bằng 1.
select subjectId, subjectName
from SUBJECT
where priority = 1;

-- Bài 3.3: Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh.
SELECT studentId, studentName, YEAR(CURRENT_DATE) - YEAR(birthday) AS age,
       CASE WHEN gender = 1 THEN 'Nam' ELSE 'Nữ' END AS gender
FROM STUDENT;



