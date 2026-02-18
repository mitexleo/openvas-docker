# OpenVAS Docker Testing

This directory contains testing configurations for the OpenVAS Docker container after the PostgreSQL 15 migration and cluster initialization fixes.

## Prerequisites

- Docker installed and running
- Docker Compose (v2 or higher)
- At least 4GB RAM available for the container
- At least 10GB disk space for vulnerability databases

## Testing Options

### 1. Test with Persistent Volume (Recommended for production-like testing)

```bash
cd testing
docker-compose -f docker-compose.yml up -d
```

This configuration:
- Uses a persistent volume (`openvas-test-data`) for database and feed storage
- Maps port 8080 on host to 9392 in container
- Uses environment variables from the compose file
- Container name: `openvas-test`

### 2. Test without Persistent Volume (Ephemeral testing)

```bash
cd testing
docker-compose -f docker-compose-no-vol.yml up -d
```

This configuration:
- No persistent storage (data lost on container stop)
- Maps port 8080 on host to 9392 in container
- Uses environment variables from the compose file
- Container name: `openvas-test-no-vol`

## Expected Behavior

### Initial Startup (First 5-10 minutes)
1. **Container starts** - PostgreSQL 15 initializes
2. **Database setup** - Empty database created or existing one migrated
3. **Services start** - Redis, PostgreSQL, gvmd, openvas scanner
4. **Feed synchronization** - If `SKIPSYNC=false` (disabled by default in tests)

### After 10-15 minutes
1. **Web interface accessible** at http://localhost:8080
2. **Login credentials**: admin/admin (unless changed via environment)
3. **Dashboard visible** with initial scan capabilities

## Monitoring Logs

```bash
# View all logs
docker logs -f openvas-test

# View specific service logs
docker exec openvas-test tail -f /var/log/gvm/gvmd.log
docker exec openvas-test tail -f /var/log/gvm/openvas.log
docker exec openvas-test tail -f /var/log/postgresql/postgresql-gvmd.log
```

## Key Tests for PostgreSQL 15 Fix

### Test 1: Cluster Initialization
The container should start without these errors:
- ✅ No "Error: cluster configuration already exists"
- ✅ No "mv: cannot stat '/var/lib/postgresql/15/main/*': No such file or directory"
- ✅ PostgreSQL 15 should start successfully

### Test 2: Database Migration
- If testing upgrade from existing data, PostgreSQL should handle version differences
- Empty database should be created cleanly

### Test 3: Persistent Storage
- Data should persist across container restarts when using volumes
- No database corruption after unexpected stops

## Environment Variables for Testing

Key environment variables you can modify:

| Variable | Default | Purpose |
|----------|---------|---------|
| `PGVER` | `15` | PostgreSQL version (now fixed to 15) |
| `SKIPSYNC` | `true` | Skip initial feed sync (faster testing) |
| `NEWDB` | `false` | Create new empty database |
| `DEBUG` | `false` | Enable debug output |
| `USERNAME` | `admin` | Web interface username |
| `PASSWORD` | `admin` | Web interface password |
| `REPORT_LINES` | `1000` | Number of lines in reports |

## Troubleshooting

### Common Issues

1. **Container exits immediately**
   ```bash
   docker logs openvas-test
   ```
   Check for PostgreSQL initialization errors.

2. **Web interface not accessible**
   ```bash
   # Check if container is running
   docker ps
   
   # Check if services are healthy
   docker exec openvas-test ps aux | grep gvmd
   docker exec openvas-test ps aux | grep postgres
   ```

3. **Out of memory errors**
   - Increase Docker memory allocation
   - Reduce `REDISDBS` environment variable

4. **Disk space issues**
   ```bash
   # Check volume usage
   docker system df
   
   # Clean unused volumes
   docker volume prune
   ```

### PostgreSQL-Specific Issues

If you encounter PostgreSQL issues related to the recent fixes:

1. **Cluster already exists error** - This should be fixed by the updated `fs-setup.sh`
2. **Permission issues** - Check `/data/database` permissions in container
3. **Version mismatch** - Ensure `PGVER=15` is set in environment

## Running Custom Tests

### Test with custom environment
```bash
cd testing
PGVER=15 SKIPSYNC=false DEBUG=true docker-compose -f docker-compose.yml up
```

### Test database restoration
```bash
# Copy backup to container
docker cp backup.sql openvas-test:/usr/lib/db-backup.sql

# Set restore flag and restart
docker stop openvas-test
docker run -d --name openvas-restore \
  -e RESTORE=true \
  -e SKIPSYNC=true \
  -p 8081:9392 \
  -v openvas-test-data:/data \
  mitexleo/openvas:latest
```

## Cleanup

```bash
# Stop and remove test container
docker-compose -f docker-compose.yml down

# Remove volumes (WARNING: deletes all data)
docker-compose -f docker-compose.yml down -v

# Remove specific test container
docker stop openvas-test && docker rm openvas-test
docker volume rm openvas-test-data
```

## Multi-Container Testing

For advanced testing, see the `../multi-container/` directory for a distributed deployment configuration.

## Reporting Issues

If you encounter issues with the PostgreSQL 15 migration or cluster initialization:

1. Capture logs: `docker logs openvas-test > openvas-test.log`
2. Note the exact error messages
3. Check container version: `docker exec openvas-test cat /ver.current`
4. Report to the issue tracker with logs and version information

## Performance Testing

For performance testing, adjust these environment variables:

```yaml
environment:
  - REDISDBS=1024  # Increase Redis databases
  - REPORT_LINES=5000  # Larger reports
  # Remove SKIPSYNC for full feed sync test
```

Remember: The initial feed sync can take 30-60 minutes and requires significant bandwidth and disk space.