import os

def root_menu (user_config_path, config_names, menu_titles):
    config_checkouts = []
    config_tags = []
    if (len(config_names)==len(menu_titles)):
        for index, config_name in enumerate(config_names):
            current_config_path = os.path.join(user_config_path,config_name)
            config_checkouts.append(f"{menu_titles[index]},^checkout({current_config_path})")
            config_tags.append(f"^tag({current_config_path})")

    for config_checkout in config_checkouts:
        print(config_checkout)

    print ("")

    for index, config_tag in enumerate(config_tags):
        config_directory_walk(os.path.join(user_config_path,config_names[index]))

def config_directory_walk (current_config_path):
    for current_directory, subdirectories, files in os.walk(current_config_path):

        print(f"^tag({current_directory})")

        for file in files:
            print(f"{file}, kitty -e nvim {os.path.join(current_directory,file)}")

        for sub in subdirectories:
            print(f"{sub}, ^checkout({os.path.join(current_directory,sub)})")
        if(len(files)==0 and len(subdirectories)==0):
            print(" ")
        print("")

root_menu(
        os.path.expanduser("~") + "/.config/",
        ("bspwm","sxhkd","jgmenu","polybar","nvim","shell","rofi","lf"),
        ("BSPWM","SXHKD","JGMenu","Polybar","Nvim","Shell","Rofi","lf"))
