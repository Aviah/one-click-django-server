function show_static_info(){

msg = "This alert is served from static files\n"
msg = msg + "======================================\n";
msg = msg + "To Serve static js, css files:\n"
msg = msg + "During dev, set DEBUG=True. Files are served directly from the repository static directory (mysite/site_repo/static) \n";
msg = msg + "When DEBUG=False, files are served from the static_root directory (Nginx serves the files with a location alias config). \n"
msg = msg + "To see static files changes in a production(or production testing), run python manage.py collectstatic, and restart Apache";
alert(msg);
}

