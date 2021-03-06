//+------------------------------------------------------------------+
//|                                                    autoentry.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
string trade = "";
string time = "";
string category = "";
string money = "";
string entry = "";
string l = "";
ushort temp_char = '\"';

int OnInit()
  {
    getCategory();
//--- indicator buffers mapping
   //ボタン削除
    ObjectDelete("buy");
    ObjectDelete("sell");
    ObjectDelete("set");
    
   //ボタン作成
    ObjectCreate(0,"buy",OBJ_BUTTON,0,0,0);
    ObjectCreate(0,"sell",OBJ_BUTTON,0,0,0);
    ObjectCreate(0,"buynow",OBJ_BUTTON,0,0,0);

   //HIGHボタン設定
    ObjectSetInteger(0,"buy", OBJPROP_CORNER, CORNER_RIGHT_UPPER); // 原点を右上に設定
    ObjectSetInteger(0,"buy",OBJPROP_COLOR,clrWhite);      //色設定
    ObjectSetInteger(0,"buy",OBJPROP_BGCOLOR,clrMediumSeaGreen);  // ボタン色
    ObjectSetInteger(0,"buy",OBJPROP_XDISTANCE, 300);                // X座標
    ObjectSetInteger(0,"buy",OBJPROP_YDISTANCE, 30);                 // Y座標
    ObjectSetInteger(0,"buy",OBJPROP_SELECTABLE,false);     //オブジェクトの選択可否設定
    ObjectSetInteger(0,"buy",OBJPROP_SELECTED,false);       //オブジェクトの選択状態
    ObjectSetInteger(0,"buy",OBJPROP_HIDDEN,true);          //オブジェクトリストの表示設定
    ObjectSetString(0,"buy",OBJPROP_TEXT,"HIGH");           //表示テキスト
    ObjectSetInteger(0,"buy",OBJPROP_XSIZE,100);            // ボタンサイズ幅
    ObjectSetInteger(0,"buy",OBJPROP_YSIZE,45);            // ボタンサイズ高さ
    ObjectSetInteger(0,"buy",OBJPROP_STATE,false);          //ボタン押下状態
    
    //LOWボタン設定
    ObjectSetInteger(0,"sell", OBJPROP_CORNER, CORNER_RIGHT_UPPER); // 原点を右上に設定
    ObjectSetInteger(0,"sell",OBJPROP_COLOR,clrWhite);      //色設定
    ObjectSetInteger(0,"sell",OBJPROP_BGCOLOR,clrIndianRed);  // ボタン色
    ObjectSetInteger(0,"sell",OBJPROP_XDISTANCE, 300);                // X座標
    ObjectSetInteger(0,"sell",OBJPROP_YDISTANCE, 80);                 // Y座標
    ObjectSetInteger(0,"sell",OBJPROP_SELECTABLE,false);     //オブジェクトの選択可否設定
    ObjectSetInteger(0,"sell",OBJPROP_SELECTED,false);       //オブジェクトの選択状態
    ObjectSetInteger(0,"sell",OBJPROP_HIDDEN,true);          //オブジェクトリストの表示設定
    ObjectSetString(0,"sell",OBJPROP_TEXT,"LOW");           //表示テキスト
    ObjectSetInteger(0,"sell",OBJPROP_XSIZE,100);            // ボタンサイズ幅
    ObjectSetInteger(0,"sell",OBJPROP_YSIZE,45);            // ボタンサイズ縦幅
    ObjectSetInteger(0,"sell",OBJPROP_STATE,false);          //ボタン押下状態
    
    //LOWボタン設定
    ObjectSetInteger(0,"buynow", OBJPROP_CORNER, CORNER_RIGHT_UPPER); // 原点を右上に設定
    ObjectSetInteger(0,"buynow",OBJPROP_COLOR,clrBlack);      //色設定
    ObjectSetInteger(0,"buynow",OBJPROP_BGCOLOR,clrGold);  // ボタン色
    ObjectSetInteger(0,"buynow",OBJPROP_XDISTANCE, 195);                // X座標
    ObjectSetInteger(0,"buynow",OBJPROP_YDISTANCE, 30);                 // Y座標
    ObjectSetInteger(0,"buynow",OBJPROP_SELECTABLE,false);     //オブジェクトの選択可否設定
    ObjectSetInteger(0,"buynow",OBJPROP_SELECTED,false);       //オブジェクトの選択状態
    ObjectSetInteger(0,"buynow",OBJPROP_HIDDEN,true);          //オブジェクトリストの表示設定
    ObjectSetString(0,"buynow",OBJPROP_TEXT,"BUYNOW");           //表示テキスト
    ObjectSetInteger(0,"buynow",OBJPROP_XSIZE,150);            // ボタンサイズ幅
    ObjectSetInteger(0,"buynow",OBJPROP_YSIZE,92);            // ボタンサイズ縦幅
    ObjectSetInteger(0,"buynow",OBJPROP_STATE,false);          //ボタン押下状態
    
    StringSetCharacter(l,0,temp_char); // エンコード
    
    //ObjectSetInteger(1,"sell",OBJPROP_COLOR,Red);
    //ObjectSetInteger(2,"set",OBJPROP_COLOR,Blue);
    
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
//--- return value of prev_calculated for next call
   return(rates_total);
  }


void OnChartEvent(
                 const int     id,      // イベントID
                 const long&   lparam,  // long型イベント
                 const double& dparam,  // double型イベント
                 const string& sparam)  // string型イベント
{

    if ( id == CHARTEVENT_OBJECT_CLICK) {         // オブジェクトがクリックされた
        if ( sparam == "buy" ) {           // "buyボタン"がクリックされた
            trade = "BUY";
            SendSignalToFile();
            trade = "";
        } else if(sparam == "sell") {
            trade = "SELL";
            SendSignalToFile();
            trade = "";
        } else if(sparam == "buynow") {
            entry = "GO";
            SendSignalToFile();
            entry = "";
        }
    }
}

  void SendSignalToFile()
{
   int FileHandle;
   string FileName = "SignalDataForHighLow.json";
   string jsonObj = "{"+l+"trade"+l+":"+l+trade+l+","+l+"time"+l+":"+l+time+l+","+l+"category"+l+":"+l+category+l+","+l+"money"+l+":"+l+money+l+","+l+"entry"+l+":"+l+entry+l+"}";
   int TryCount;
 
   FileHandle = FileOpen(FileName,FILE_WRITE|FILE_TXT|FILE_COMMON);
   TryCount = 0;
   while( FileHandle == INVALID_HANDLE && TryCount < 30)
   {
      TryCount++;
      FileHandle = FileOpen(FileName,FILE_WRITE|FILE_TXT|FILE_COMMON);
   }
      
   if( FileHandle != INVALID_HANDLE )
   {
      FileWrite(FileHandle,jsonObj);
      FileClose(FileHandle);
   }

}

  void getCategory()
{
   string firstCurrency,secondCurrency; // 通貨ペア名のみ取得
   firstCurrency = StringSubstr(Symbol(), 0, 3);
   secondCurrency = StringSubstr(Symbol(), 3, 6);
   category = StringConcatenate(firstCurrency, "/", secondCurrency);
}

  int deinit(){
    trade = "";
    time = "";
    category = "";
    money = "";
    entry = "";
    SendSignalToFile();

   ObjectDelete("buy");
   ObjectDelete("sell");
   ObjectDelete("set");
   return(0);
}
//+------------------------------------------------------------------+