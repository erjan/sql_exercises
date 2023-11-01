'''
You have been tasked with designing three classes: text_editor, moving_text_editor, and smart_text_editor. These classes are to be created with specific functionalities as defined below:

text_editor class:

write_line(string:str): A method which appends a given string to the end of the existing string.
delete_line(char_num : int): A method which deletes char_num number of characters from the existing string, starting from the end. If there are no characters left, the method should do nothing.
special_operation(): A method which currently does nothing.
get_notes(): A method which returns the internal string.
moving_text_editor class:

This class extends text_editor. The special_operation() method is overridden. Initially, the cursor will be at the end of the current string. If special_operation() is called, it moves the cursor to the beginning of the string, any additional appends will be appended to the beginning of the string instead. Calling special_operation() again reverses the cursor operation.
smart_text_editor class:

This class extends text_editor. In this class, the special_operation() method is overridden to serve as an undo operation, allowing it to undo an infinite number of operations.
'''


from typing import Union
class text_editor():
    def __init__(self):
        self.main = ''
        self.cursor_at_end= True
    
    def write_line(self, s):
        if self.cursor_at_end:
            self.main += s
        else:
            self.main = s + self.main
    
    def delete_line(self,char_num):
        self.main = self.main[:-char_num]   if char_num< len(self.main) else ''    
    
    def get_notes(self):
        return self.main
    
    def special_operation(self):
        pass


class moving_text_editor(text_editor):
    def __init__(self):
        super().__init__()

    def special_operation(self):
        self.cursor_at_end = not self.cursor_at_end


class smart_text_editor(text_editor):
    def __init__(self):
        super().__init__()
        self.history = []

    def write_line(self, string: str):
        self.history.append(self.main)
        super().write_line(string)

    def delete_line(self, char_num: int):
        self.history.append(self.main)
        super().delete_line(char_num)

    def special_operation(self):
        if self.history:
            self.main = self.history.pop()




# Do not delete. 
def run_editors(factory: str, operations: list, arguments: list):
    editor: Union[None, text_editor] = None
    if factory == 'text_editor':
        editor = text_editor()
    elif factory == 'moving_text_editor':
        editor = moving_text_editor()
    else:
        editor = smart_text_editor()
    for operation in operations:
        if operation == 'write_line':
            editor.write_line(arguments.pop(0))
        elif operation == 'delete_line':
            editor.delete_line(arguments.pop(0))
        else:
            editor.special_operation()
    return editor.get_notes()
