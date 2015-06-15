def check_password(environ,user,password):

    if user == "apacheusername":
        if password == "apachepasswd":
            return True
        return False
    return None
