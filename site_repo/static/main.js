function show_static_info(){

msg = "This alert is served from static files\n"
msg = msg + "=============\n";
msg = msg + "To Serve static js, css files:\n"
msg = msg + "Django development server (development): Set DEBUG=True. Files are served directly from the repository static directory by django (mysite/site_repo/static) \n";
msg = msg + "Nginx/Apache + DEBUG=False (production): Files are served from the static_root directory, by Nginx location alias. \n"
msg = msg + "Nginx/Apache + DEBUG=True (testing): Files are served directly from the repository static directory by django (mysite/site_repo/static) \n";
msg = msg + "See Readme"
alert(msg);
}

