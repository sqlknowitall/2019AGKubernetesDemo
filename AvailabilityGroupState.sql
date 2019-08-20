SELECT  r.replica_server_name
      , DB_NAME(rs.database_id) AS [DatabaseName]
      , rs.is_local
      , rs.is_primary_replica
      , r.availability_mode_desc
      , r.failover_mode_desc
	  , rs.is_commit_participant			--value is only valid on primary replica, 0 is replica is behind or offline
      , rs.synchronization_state_desc		--in synchronous mode - look for synchronized, async should be synchronizing
      , rs.synchronization_health_desc		--in synchronous mode - healthy when synchronized, partially when synchronizing, not healthy when not sync'ing. in asynchnous mode - healthy when synchronizing, not healthy when not sync'ing
      , r.endpoint_url
      , r.session_timeout
FROM    sys.dm_hadr_database_replica_states rs
        JOIN sys.availability_replicas r ON r.group_id = rs.group_id
                                            AND r.replica_id = rs.replica_id
ORDER BY r.replica_server_name;
GO
