String[] expDxf = new String [47];

void dxfHeader() {
  expDxf = new String [] {
    "0", "SECTION", "2", "TABLES", "0", "TABLE", "2", "LAYER", "70", "6", 
    "0", "LAYER", "2", "layer 1", "70", "64", "62", "2", "6", "CONTINUOUS",
    "0", "LAYER", "2", "layer 2", "70", "64", "62", "4", "6", "CONTINUOUS",
    "0", "LAYER", "2", "layer 3", "70", "64", "62", "5", "6", "CONTINUOUS",
    "0", "LAYER", "2", "layer 4", "70", "64", "62", "3", "6", "CONTINUOUS",
    "0", "ENDTAB", "0", "TABLE", "2", "STYLE", "70", "0", "0", "ENDTAB", "0", "ENDSEC", "0", "SECTION", "2", "ENTITIES", "0"
  };
}

void dxfEnd() {
  expDxf = expand(expDxf, expDxf.length+3 );
  expDxf[expDxf.length-3] = "ENDSEC";
  expDxf[expDxf.length-2] = "0";
  expDxf[expDxf.length-1] = "EOF" ;
  saveStrings("expChair.dxf", expDxf);
}

void dxfCircle(float x, float y, float xco1, float yco1, float rad, String layer) {
  
  int oldLen = expDxf.length;
  int newLen = (expDxf.length+12);
  expDxf = expand(expDxf, newLen );
  
  expDxf[oldLen] = "CIRCLE";
  expDxf[oldLen+1] = "8";
  expDxf[oldLen+2] = layer;
  expDxf[oldLen+3] = "10";
  expDxf[oldLen+4] = str(xco1+x);
  expDxf[oldLen+5] = "20";
  expDxf[oldLen+6] = str(yco1+y);
  expDxf[oldLen+7] = "30";
  expDxf[oldLen+8] = "0.0";
  expDxf[oldLen+9] = "40";
  expDxf[oldLen+10] = str(rad);
  expDxf[oldLen+11] = "0";
}
