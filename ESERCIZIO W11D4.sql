-- ESERCIZIO W11D4

-- 1
SELECT g.Name AS Genere, COUNT(t.TrackId) AS Num_tracce
FROM track AS t
INNER JOIN genre AS g
ON t.GenreId=g.GenreId
GROUP BY g.Name
HAVING COUNT(t.TrackId)>=10
ORDER BY Num_tracce;


-- 2
SELECT *
FROM track
WHERE MediaTypeId <> 3
ORDER BY UnitPrice DESC
LIMIT 3;


-- 3
SELECT ar.Name AS Artista
FROM artist AS ar
INNER JOIN album AS al
ON ar.ArtistId=al.ArtistId
INNER JOIN track AS t
ON al.AlbumId=t.AlbumId
WHERE t.Milliseconds >360000;


-- 4
SELECT g.Name AS Genere, AVG(t.Milliseconds) AS DurataMedia
FROM track AS t
INNER JOIN genre AS g
ON t.GenreId=g.GenreId
GROUP BY g.Name;


-- 5
SELECT g.Name AS Genere, t.Name AS Titolo
FROM track AS t
INNER JOIN genre AS g
ON t.GenreId=g.GenreId
WHERE t.Name LIKE '%Love %' OR t.Name LIKE '% Love' OR t.Name LIKE 'Love'
ORDER BY g.Name, t.Name;


-- 6
SELECT m.Name AS Mediatype, AVG(t.UnitPrice)
FROM track AS t
INNER JOIN mediatype AS m
ON t.MediaTypeId=m.MediaTypeId
GROUP BY m.Name;


-- 7
SELECT g.Name AS Genere
FROM genre AS g
INNER JOIN track AS t
ON g.GenreId=t.GenreId
GROUP BY g.Name 
HAVING COUNT(DISTINCT t.TrackId)=(SELECT MAX(num_track)
								  FROM (SELECT g.Name AS Genere, COUNT(DISTINCT t.TrackId) AS num_track
                                        FROM  track AS t
										INNER JOIN genre g ON g.GenreId=t.GenreId
                                        GROUP BY g.Name) A);
                                        
								
-- 8
SELECT ar.Name AS Artista, COUNT(al.AlbumId) AS Num_album
FROM artist AS ar
INNER JOIN album AS al
ON ar.ArtistId=al.ArtistId
GROUP BY ar.Name
HAVING COUNT(al.AlbumId)=(SELECT COUNT(al.AlbumId)
                          FROM artist AS ar
                          INNER JOIN album AS al
                          ON ar.ArtistId=al.ArtistId
                          GROUP BY ar.Name
                          HAVING ar.Name LIKE "The Rolling Stones");
				

-- 9
SELECT ar.Name AS Artista, al.Title AS Titolo, SUM(t.UnitPrice) AS Costo_album
FROM artist AS ar
INNER JOIN album AS al
ON ar.ArtistId=al.ArtistId
INNER JOIN track AS t
ON t.AlbumId=al.AlbumId
GROUP BY ar.Name, al.Title
ORDER BY SUM(t.UnitPrice) DESC
LIMIT 1;






