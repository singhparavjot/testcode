DECLARE
  l_task_id NUMBER;
BEGIN
  -- Create a task to list contents in a specific path of an S3 bucket
  l_task_id := rdsadmin.rdsadmin_s3_tasks.list_s3(
                 p_bucket_name    => 'your-bucket-name',
                 p_s3_prefix      => 'your-s3-directory-path/'); -- Optional: Specify a directory path in S3

  -- Output the task ID
  DBMS_OUTPUT.put_line('Task ID for listing S3 contents: ' || l_task_id);

  -- Optionally, add code here to monitor the task status and output results
END;
