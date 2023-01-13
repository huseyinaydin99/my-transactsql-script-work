CREATE PROC SP_GETITEMINFO 11369
@ITEMCODE AS VARCHAR(100)
AS
SELECT *,TOTALSALE/TOTALCATEGORYSALE CATEGORYPERCENT,
TOTALSALE/TOTALBRANDSALE BRANDPERCENT
FROM
(
SELECT  
 
I.ITEMCODE,I.ITEMNAME,I.BRAND,I.CATEGORY1,COUNT(OD.ID) ORDERCOUNT,
MIN(OD.UNITPRICE) MINSALEPRICE,MAX(OD.UNITPRICE) MAXSALEPRICE,AVG(OD.UNITPRICE) AVGSALEPRICE,
SUM(OD.LINETOTAL) TOTALSALE,SUM(OD.AMOUNT) TOTALAMOUNT,

(SELECT SUM(LINETOTAL) FROM ORDERDETAILS WHERE 
	ITEMID IN (SELECT ID FROM ITEMS WHERE CATEGORY1 =I.CATEGORY1)
) TOTALCATEGORYSALE,

(SELECT SUM(LINETOTAL) FROM ORDERDETAILS WHERE 
	ITEMID IN (SELECT ID FROM ITEMS WHERE BRAND =I.BRAND)
) TOTALBRANDSALE

FROM ORDERDETAILS OD
JOIN ORDERS O ON O.ID=OD.ORDERID 
JOIN ITEMS I ON I.ID=OD.ITEMID 
WHERE I.ITEMCODE =@ITEMCODE 
GROUP BY I.CATEGORY1, I.ITEMCODE,I.ITEMNAME,I.BRAND
)T 