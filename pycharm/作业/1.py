count = 0  # 输入三次后确定是否继续，计数器
lock_num = 1  # 三次密码错误后锁定，计数器
while 1:
    count += 1  # 计数器
    if count <= 3:   # 输入小于等于3次，则提示输入账号和密码
        username = input("pls input username:")
        password = input("pls input password:")
    elif count > 3:  # 输入三次后，确认是否需要继续
        confirm = input("确定是否需要继续! y/n:").strip()
        if confirm == "y":
            count = 1
            username = input("pls input username:")
            password = input("pls input password:")
        elif confirm == "n":  # "n" 是退出程序
            exit("已退出,再见!!!")
            username = input("pls input username:")
            password = input("pls input password:")

    with open("passwd",mode="r",encoding="utf8") as f_read,open("locked",mode="r+",encoding="utf8") as f_write:
        # 打开用户密码文件和锁定文件
        for lock in f_write:  # 判断账户是否已经被锁定
            lock_user=lock.strip()
            if username == lock_user:
                print("账号已被锁定，请联系管理员解锁")
                break
        else: # 如果没有被锁定，则进行匹配用户名和密码操作
            for line in f_read:
                user=line.strip().split("|")[0]  # 用户名
                pwd=line.strip().split("|")[1]  # 密码
                if username == user:  # 正确的匹配用户名
                    if password == pwd:  # 正确的匹配密码，显示登录成功
                        print("登录成功")
                        lock_num = 0 # 登录成功后，锁定计数器改为0
                        break
                    else:  # 密码输入错误
                        print(lock_num)
                        if lock_num >= 3:
                            f_write.write(user+"\n")
                            print("错误输入超过三次，账号已被锁定，请联系管理员解锁")
                            lock_num = 0 # 锁定用户名后，计数器改为0
                            break
                        print("密码输入错误，请重新输入")
                        break
            else:
                print("密码输入错误，请重新输入")  # 账号不存在，重新输入
    lock_num += 1