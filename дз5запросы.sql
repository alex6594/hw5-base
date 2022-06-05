select genres.genre_name, genres.id, count(*) from genres
join musiciansgenre on genres.id = musiciansgenre.genre_id 
group by genres.genre_name,genres.id  

select album_name, count(*) from albums 
join tracks on tracks.album_id = albums.id
where albums.year_of_issue between 2019 and 2020
group by album_name

select album_name, avg(track_duration) from tracks
join albums on albums.id = tracks.album_id  
group by album_name

select alias from albums 
join musicians on musicians.id=albums.id
where albums.year_of_issue != 2020
group by alias

select compilation_name from compilation
join tracksalbums on tracksalbums.compilation_id  = compilation.id  
join tracks on tracks.id = tracksalbums.track_id 
join albums on albums.id = tracks.album_id 
join albumperformer on albumperformer.album_id = tracks.album_id
join musicians on musicians.id = albumperformer.performer_id 
where musicians.alias ='Twisted Sister'

select album_name from albums
left join albumperformer on albumperformer.performer_id  = albums.id
left join musicians on musicians.id = albumperformer.album_id 
left join musiciansgenre on musicians.id = musiciansgenre.genre_id 
left join genres on genres.id = musiciansgenre.musician_id 
group by album_name
having count(distinct genre_name)>1

select track_name from tracks 
left join tracksalbums on tracksalbums.track_id  = tracks.id 
left join compilation on compilation.id = tracksalbums.compilation_id 
group by track_name 
having count(tracksalbums.track_id) = 0

select alias,track_duration  from tracks
left join albums on albums.id = tracks.album_id 
left join albumperformer on albumperformer.performer_id = albums.id 
left join musicians on musicians.id = albumperformer.album_id 
group by alias,track_duration
having track_duration = (select min(track_duration) from tracks)
order by alias

select album_name
from albums a
left join tracks t on t.album_id  = a.id
where t.album_id in (
    select album_id from tracks
    group by album_id
    having count(id) = (select count(id) from tracks
    group by album_id
    order by count
    limit 1
    )
)
order by a.album_name 