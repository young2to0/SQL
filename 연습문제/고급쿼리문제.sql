-- 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
SELECT name
FROM customer
WHERE  NOT custid = (SELECT custid FROM customer WHERE name='박지성') 
AND custid IN (SELECT orders.custid
				       FROM book INNER JOIN orders
                    ON book.bookid=orders.bookid
                WHERE publisher IN (SELECT publisher
									                  FROM book
									                  WHERE bookid IN (SELECT bookid
												                             FROM orders
                                                    WHERE custid=(SELECT custid
                                                                  FROM customer
                                                                  WHERE name='박지성'))));
                                                                  
-- 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
SELECT name
FROM customer
WHERE custid IN ( SELECT orders.custid
                  FROM book,orders
                  WHERE book.bookid=orders.bookid
                  GROUP BY orders.custid
                  HAVING COUNT(publisher)>=2);
                  
-- 전체 고객의 30%이상이 구매한 도서
SELECT bookname
FROM book
WHERE bookid IN(SELECT bookid
                FROM orders
                GROUP BY bookid
                HAVING COUNT(custid)>= (SELECT COUNT(custid)*0.3
                                        FROM customer)); 
