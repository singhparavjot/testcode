DECLARE
  req   UTL_HTTP.req;
  resp  UTL_HTTP.resp;
  value VARCHAR2(1024);

  -- Endpoint for the S3 service (generic, not specific to a bucket)
  url VARCHAR2(4000) := 'https://s3.amazonaws.com/';
BEGIN
  -- Make the request
  req := UTL_HTTP.begin_request(url);

  -- Get the response
  resp := UTL_HTTP.get_response(req);

  -- Read and output the response
  BEGIN
    LOOP
      UTL_HTTP.read_line(resp, value, TRUE);
      DBMS_OUTPUT.put_line(value);
    END LOOP;
    UTL_HTTP.end_response(resp);
  EXCEPTION
    WHEN UTL_HTTP.end_of_body THEN
      UTL_HTTP.end_response(resp);
  END;

EXCEPTION
  WHEN OTHERS THEN
    -- Handle and output errors
    DBMS_OUTPUT.put_line('Error: ' || SQLERRM);
    -- Close the request and response if they are open
    BEGIN
      UTL_HTTP.end_request(req);
    EXCEPTION
      WHEN OTHERS THEN
        NULL; -- Ignore errors in closing the request
    END;

    BEGIN
      UTL_HTTP.end_response(resp);
    EXCEPTION
      WHEN OTHERS THEN
        NULL; -- Ignore errors in closing the response
    END;
END;
