
SELECT CITY, [Ocak],[Þubat],[Mart],[Nisan],[Mayýs],[Haziran],[Temmuz],[Aðustos],[Eylül],[Ekim],[Kasým],[Aralýk]
FROM
(
SELECT CITY,DATENAME(MONTH,DATE_) MONTH_,TOTALPRICE FROM SALES 
)AS ST

PIVOT
(
SUM(TOTALPRICE) FOR MONTH_ IN ([Ocak],[Þubat],[Mart],[Nisan],[Mayýs],[Haziran],[Temmuz],[Aðustos],[Eylül],[Ekim],[Kasým],[Aralýk])
)AS PVT 