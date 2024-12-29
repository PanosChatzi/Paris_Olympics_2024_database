-- Starts PostgreSQL server using Docker
docker run --name postgres -p 5432:5432 -v /workspaces/$RepositoryName:/mnt -e POSTGRES_PASSWORD=crimson -d postgres

-- Logs in, if using 'crimson' as password
psql postgresql://postgres@127.0.0.1:5432/postgres

-- If stopped, start the container
docker start postgres

-- Initiate bash in container
docker exec -it postgres bash

-- Start postgres
psql -U postgres
