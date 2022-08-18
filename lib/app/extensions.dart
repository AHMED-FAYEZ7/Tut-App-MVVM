// extension on string

String EMPTY = "";
int ZERO = 0;
extension NonNullString on String?{
  String orEmpty(){
    if(this == null){
      return EMPTY;
    }else {
      return this!;
    }
  }
}

// extension on int

extension NonNullInt on int?{
  int orZero(){
    if(this == null){
      return ZERO;
    }else {
      return this!;
    }
  }
}

