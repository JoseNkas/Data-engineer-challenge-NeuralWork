use mysql_python;

-- se visualizan las coordenadas de la tabla 
select
	region,
	ST_X(origin_coord) as Coord_ORX, 
 	ST_Y(origin_coord) as Coord_ORY,
	ST_X(destination_coord) as Coord_DX,
    ST_Y(destination_coord) as Coord_DY,
    datetime,
    datasource
from trips
where region in(select region from trips)
order by  Coord_ORX DESC, Coord_DX DESC, datetime DESC, region;

-- Desarrollo pregunta 1.a
Select 
	region,
	hour(datetime) as hr,
    count(region) as N_viaje

from trips
group by hr ,region
having count(region)>=1
order by hr DESC , region DESC;
-- Coord_ORX DESC, Coord_DX DESC, datetime DESC,-- 
	
    
Select 
	region,
	max(ST_X(origin_coord)) as MAX_OX,
    min(ST_Y(origin_coord)) as MIN_OY,
    max(ST_X(destination_coord)) as MAX_DX,
    min(ST_Y(destination_coord)) as MIN_DY,
    abs(max(ST_X(origin_coord))-max(ST_X(destination_coord))) as Rango_X,
    abs(min(ST_Y(origin_coord))-min(ST_Y(destination_coord))) as Rango_Y,
    count(region)
from trips
where region in(select region from trips)
group by region
order by region DESC;

Select 
	region,
	AVG(ST_X(origin_coord)) as AV_OX,
    AVG(ST_Y(origin_coord)) as AV_OY,
    AVG(ST_X(destination_coord)) as AV_DX,
    AVG(ST_Y(destination_coord)) as AV_DY
from trips
where region in(select region from trips)
group by region
order by region DESC;



Select 
	week(datetime) as WK,
    count(region) as N_viaje,
    region
from trips
group by wk ,region
having count(region)>=1
order by wk DESC , region DESC;

-- Desarrollo pregunta 2.a
select
	region,
	avg(st_distance(origin_coord,destination_coord)) as media_distance_OD
from trips 
where region in (select region from trips)
group by region
order by region DESC;

-- DEsarrollo pregunta 2.a
select 
	region,
    week(datetime) as WK,
	sum(st_within(destination_coord,st_buffer(st_Geomfromtext('POINT(10.723103075342998 49.55017965050226)'),5.4))) as bounding_box
from trips 
where region in (select region from trips)
group by region, wk
order by wk DESC , region DESC;

select 
	region,
    week(datetime) as WK,
	st_within(destination_coord,st_buffer(st_Geomfromtext('POINT(10.723103075342998 49.55017965050226)'),5.4)) as bounding_box
from trips 
-- where region in (select region from trips)
-- group by region, wk
order by wk DESC , region DESC;








