class TextFieldState{
   bool isObscured;

  TextFieldState(this.isObscured);
}
sealed class TextFieldAction{}

class TogglePassWordVisibility extends TextFieldAction{}