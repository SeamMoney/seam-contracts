from parseMove import start

def user_prompts():
    """Prompts user for input."""
    print("Welcome to SideWinder!")
    print("Please enter the module name:")
    module_name = input()
    print("Please enter the named address:")
    named_addresses = [input()]
    
    print("Would you like to test the module after compile? (y/n)")
    test = input()
    return module_name, named_addresses, test.lower() == "y"


# main function with cli arguments
def main():
    # module_name, named_addresses, test = user_prompts()
    
    start("file",True,["seam"])

    


    # Prompt user for input
main()