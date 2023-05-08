def areBracketsBalanced(arg):
    arr = []
 
    # Looping through argument
    for item in arg:
        if item in ["(", "{", "["]:
 
            # if item is opening bracket push it to the arr
            arr.append(item)
        else:
 
            # IF current item is not opening bracket, then it must be closing.
            # if closing matches last opening then balanced, if not then not balanced
            current_item = arr.pop()
            if current_item == '(':
                if item != ")":
                    return False
            if current_item == '{':
                if item != "}":
                    return False
            if current_item == '[':
                if item != "]":
                    return False
 
    # Check Empty arr
    if arr:
        return False
    return True
 
 
arg = [ "{[()]}", "{[(])}", "{{[[(())]]}}"]
#calling function
for i in arg:
  if areBracketsBalanced(i):
    print("Balanced")
  else:
    print("Not Balanced")