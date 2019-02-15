local a,b=guiGetScreenSize()styles={}styles['default']={window={color=tocolor(255,255,255,255),bgColor=tocolor(0,0,0,225),borderColor=tocolor(255,255,255,255),closeColor=tocolor(255,255,255,255),closeBgColor=tocolor(0,0,0,200),closeBgHover=tocolor(255,0,255,120),titleColor=tocolor(255,255,255,255),titleBgColor=tocolor(111,111,111,255),titleHeight=28,borderSize=1,shadow=true},button={color=tocolor(255,255,255,255),bgColor=tocolor(65,65,65,235),borderColor=tocolor(255,255,255,255),hover=tocolor(180,180,180,255),bgHover=tocolor(45,45,45,235),enabledColor=tocolor(0,0,0,200),fontSize=1.60,shadow=true},checkbox={color=tocolor(255,255,255,255),bgColor=tocolor(0,0,0,50),hover=tocolor(210,210,210,255),bgSelected=tocolor(0,0,0,255),enabledColor=tocolor(0,0,0,200),shadow=true},progressbar={color=tocolor(255,255,255,255),bgColor=tocolor(0,0,0,160),innerColor=tocolor(255,255,255,255),progressColor=tocolor(55,75,255,255),enabledColor=tocolor(0,0,0,200),spacing=4,fontSize=1.20,shadow=true},list={mainBg={color=tocolor(0,0,0,255)},itemBg={color=tocolor(50,50,50,255)},itemText={color=tocolor(255,255,255,255),font="default",size=1,shadow=false},itemHover={bgColor=tocolor(100,100,100,255),textColor=tocolor(200,200,55,255),font="default",size=1},itemSelect={color=tocolor(44,150,150,255),font="default",size=1}}}styles['win95']={window={color=tocolor(255,255,255,255),bgColor=tocolor(191,191,191,205),borderColor=tocolor(255,255,255,255),closeColor=tocolor(255,255,255,255),closeBgColor=tocolor(0,0,0,200),closeBgHover=tocolor(255,0,255,120),titleColor=tocolor(255,255,255,255),titleBgColor=tocolor(55,111,255,255),titleHeight=28,borderSize=1,shadow=true},button={color=tocolor(255,255,255,255),bgColor=tocolor(115,115,115,235),borderColor=tocolor(255,255,255,255),hover=tocolor(180,180,180,255),bgHover=tocolor(95,95,95,235),enabledColor=tocolor(151,151,151,220),fontSize=1.6,shadow=true},checkbox={color=tocolor(255,255,255,255),bgColor=tocolor(0,0,0,50),hover=tocolor(210,210,210,255),bgSelected=tocolor(0,0,0,255),enabledColor=tocolor(151,151,151,220),shadow=true}}function getStyleList()local c={}for d in pairs(styles)do c[#c+1]=d end;return c end;function getStyle(e,f)local g=styles[e][f]return g and table.copy(g)end;function mouse()local h,i=getCursorPosition()return h and Vector2(h*a,i*b)or false end;function table.copy(j)local k={}for d,l in pairs(j)do if type(l)=="table"then l=table.copy(l)end;k[d]=l end;return k end;elements={}dx={}function dx.new(f,m,n,o,p)local self={type=f,x=m,y=n,w=o,h=p,visible=true,parent=nil,children={},ox=m,oy=n,onclick=function()end,ontop=false,enabled=true,style=getStyle('default',f),styleType='default'}function self.destroy()local q=elements[self.type]for r=1,#q do if q[r]==self then for r=1,#self.children do self.children[r].destroy()end;return table.remove(q,r)end end end;function self.setPosition(m,n)self.x=m;self.y=n;return self end;function self.getPosition()return self.x,self.y end;function self.setSize(o,p)self.w=o;self.h=p;return self end;function self.getSize()return self.w,self.h end;function self.setVisible(l)self.visible=l;return self end;function self.getVisible()return self.visible end;function self.setEnabled(l)self.enabled=l;return self end;function self.getEnabled()return self.enabled end;function self.click(s)self.onclick=s;return self end;function self.setParent(t)self.parent=t;if self.type~='list'then self.style=getStyle(t.styleType,self.type)end;table.insert(t.children,self)return self end;function self.setStyle(e)self.style=getStyle(e,self.type)self.styleType=e;for r=1,#self.children do local u=self.children[r]u.style=getStyle(e,u.type)end;return self end;function self.css(...)if arg[2]and type(arg[1])=="string"then self.style[arg[1]]=arg[2]elseif type(arg[1])=="table"then for d,l in pairs(arg[1])do self.style[d]=l end end;return self end;local v=0;local w=0;local x;local y;local z;local A=false;local function B(C,D)v=v*0.90;w=w*0.90;v=v+C;w=w+D;self.x=self.x+v;self.y=self.y+w;local E=getDistanceBetweenPoints2D;if E(self.x,self.y,x,y)<0.05 then if z then z()end;A=false end;return self end;function self.update()if not self.enabled then dxDrawRectangle(self.x,self.y,self.w,self.h,self.style.enabledColor)end;if A then local C=x-self.x;local D=y-self.y;B(C*0.01,D*0.01)end end;function self.tween(m,n,F,s)x=m;y=n;z=s;A=true;return self end;function self.align(G)if not self.parent then if G=="center"then self.x=a/2-self.w/2;self.y=b/2-self.h/2 elseif G=="centerY"then self.y=b/2-self.h/2 elseif G=="centerX"then self.x=a/2-self.w/2 end else if G=="center"then self.ox=self.parent.w/2-self.w/2;self.oy=self.parent.h/2-self.h/2 elseif G=="centerY"then self.oy=self.parent.h/2-self.h/2 elseif G=="centerX"then self.ox=self.parent.w/2-self.w/2 end end;return self end;function self.mouseOn(m,n,o,p)local H=mouse()if H then if not m then if H.x>=self.x and H.x<=self.x+self.w and H.y>=self.y and H.y<=self.y+self.h then return true end else if H.x>=m and H.x<=m+o and H.y>=n and H.y<=n+p then return true end end end;return false end;function self.setontop()local q=elements[self.type]for r=1,#q do local t=q[r]if t==self then table.remove(q,r)table.insert(q,1,self)t.ontop=true else t.ontop=false end end;return self end;function self.mouseDown()if self.mouseOn()then return getKeyState('mouse1')end;return false end;return self end;addEventHandler('onClientRender',root,function()for f,q in pairs(elements)do for r=#q,1,-1 do local t=q[r]if not t.parent then if t.visible then t.draw()t.update()if f~='window'then t.ontop=true end end;for I=1,#t.children do local u=t.children[I]u.x=u.ox+t.x;u.y=u.oy+t.y;u.ontop=t.ontop;u.visible=t.visible;if u.visible then u.draw()u.update()end end;if f=='window'and t.visible and t.showBorders then t.drawBorders()end end end end end)local J={'backspace','mouse1','mouse_wheel_up','mouse_wheel_down','arrow_d','arrow_u','arrow_l','arrow_r','enter'}addEventHandler('onClientKey',root,function(K,L)for r=1,#J do if K==J[r]then for f,q in pairs(elements)do for r=1,#q do local t=q[r]local M=t.mouseOn()if t.visible and t.enabled then if K=='mouse1'and L then if f=='window'then if M then return t.setontop()else t.ontop=false end end end;if t.ontop then if t.onKey then local s=t.onKey(K,L)if s then return s()end end end end end end end end end)elements.input={}function input(N,m,n,o,p)local self=dx.new('input',m,n,o,p)self.text=N;self.masked=false;self.readonly=false;self.maxLength=nil;self.active=false;self.font="default-bold"self.fontSize=1.35;function self.draw()local N=self.masked and string.rep("*",self.text:len())or self.text;local O=dxGetTextWidth(N,self.fontSize,self.font,false)dxDrawRectangle(self.x,self.y,self.w,self.h,tocolor(255,255,255,255))dxDrawText(N,self.x,self.y,self.x+self.w,self.y+self.h,tocolor(28,27,28,255),self.fontSize,self.font,"left","center",true,false,true,false,false)if self.active and getTickCount()%1000<500 then local m=O<self.w and self.x+O or self.x+self.w-3;local n=self.y+5;dxDrawRectangle(m,n,2,24,tocolor(22,22,22,255),true)end end;function self.cancelCharEvent()guiSetInputMode("allow_binds")removeEventHandler("onClientCharacter",root,self.onChar)self.active=false end;function self.onChar(P)if self.visible then self.text=self.text..P else self.cancelCharEvent()end end;function self.onKey(K,L)if K=='mouse1'then if self.mouseOn()then if not self.active then guiSetInputMode("no_binds")addEventHandler("onClientCharacter",root,self.onChar)self.active=true end else self.cancelCharEvent()end elseif K=='backspace'and L then if self.active then self.text=self.text:sub(1,-2)end end end;table.insert(elements.input,1,self)return self end;elements.list={}function grid(N,m,n,o,p)local self=dx.new('list',m,n,o,p)self.title=N;self.titleHeight=30;self.showTitleBar=true;self.items={}self.itemh=35;self.itemSpacing=2;self.selectedItem=0;self.sb={w=16,thumb={}}self.maxItems=nil;self.sp=1;self.ep=nil;self.onselect=function()end;function self.addItem(Q,R,S,T)local U={}U.id=#self.items;U.title=Q;U.data=R;U.color=S;U.draw=T;U.onclick=function()end;U.onDoubleClick=function()end;table.insert(self.items,U)return U end;function self.clear()self.items={}self.selectedItem=0;self.sp=1 end;function self.sortByTitle()local V=function(W,X)return W.title<X.title end;table.sort(self.items,V)end;function self.onKey(K,L)if K=='arrow_d'then if L then return self.selectNextItem()end elseif K=='arrow_u'then if L then return self.selectPrevItem()end elseif K=='enter'then if not L then if self.items[self.selectedItem]then return self.items[self.selectedItem].onclick()end end elseif K=='mouse1'and self.mouseOn()then if not L then for I=self.sp,self.ep do local U=self.items[I]if U then if self.mouseOn(U.x,U.y,U.w,U.h)then self.selectedItem=I;return U.onclick end end end end elseif K=='mouse_wheel_up'then return self.scroll('up')elseif K=='mouse_wheel_down'then return self.scroll('down')end end;function self.selectNextItem()if self.selectedItem==self.ep then self.scroll('down')end;if self.selectedItem>=#self.items then self.selectedItem=1;self.sp=1 else self.selectedItem=self.selectedItem+1 end;self.onselect(self.items[self.selectedItem])end;function self.selectPrevItem()if self.selectedItem==self.sp then self.scroll('up')end;if self.selectedItem<=1 then self.selectedItem=#self.items;self.sp=#self.items>self.maxItems and#self.items-self.maxItems or 1 else self.selectedItem=self.selectedItem-1 end;self.onselect(self.items[self.selectedItem])end;function self.draw()local e=self.style;dxDrawRectangle(self.x,self.y,self.w,self.h,e.mainBg.color,false)dxDrawRectangle(self.x,self.y,self.w,self.titleHeight,e.mainBg.color,false)dxDrawText(self.title,self.x,self.y,self.x+self.w,self.y+self.titleHeight,e.itemText.color,1.25,"default","center","center",true,false,false,false,false)self.sb.x=self.x+self.w-self.sb.w;self.sb.y=self.y+self.titleHeight;self.sb.w=self.sb.w;self.sb.h=self.h-self.titleHeight;self.sb.thumb.y=self.sb.y+self.sb.w;self.sb.thumb.h=22;dxDrawRectangle(self.sb.x,self.sb.y,self.sb.w,self.sb.h,tocolor(77,77,77,255),false)dxDrawRectangle(self.sb.x,self.sb.thumb.y,self.sb.w,self.sb.thumb.h,tocolor(177,177,177,255),false)dxDrawText("▲",self.sb.x,self.sb.y,self.sb.x+self.sb.w,self.sb.y+self.sb.w,tocolor(211,211,211,255),1.2,"default","center","center",true,false,true,false,false)dxDrawText("▼",self.sb.x,self.y+self.h-self.sb.w,self.x+self.w,self.y+self.h,tocolor(211,211,211,255),1.2,"default","center","center",true,false,true,false,false)self.drawItems()end;function self.scroll(G)if G=="up"then if self.sp>1 then self.sp=self.sp-1 end;return end;if G=="down"then if self.sp<#self.items-self.maxItems then self.sp=self.sp+1 end end end;function self.drawItems()local e=self.style;local Y=self.itemh+self.itemSpacing;self.maxItems=math.floor((self.h+self.itemSpacing-self.titleHeight)/Y)-1;self.ep=self.sp+self.maxItems;for r=self.sp,self.ep do local U=self.items[r]if U then U.id=r;Y=r>self.sp and Y+self.itemh+self.itemSpacing or 0;U.x=self.x;U.y=self.y+self.titleHeight+Y;U.w=self.w-self.sb.w;U.h=self.itemh;local M=self.ontop and self.mouseOn(U.x,U.y,U.w,U.h)local Z=M and e.itemHover.font or e.itemText.font;local _=M and e.itemHover.size or e.itemText.size;local a0=self.selectedItem==r and e.itemSelect.textColor or M and e.itemHover.textColor or U.color or e.itemText.color;local a1=self.selectedItem==r and e.itemSelect.color or M and e.itemHover.bgColor or e.itemBg.color;dxDrawRectangle(U.x,U.y,U.w,U.h,a1,false)if U.draw and type(U.draw)=="function"then U.draw(U)end;if e.itemText.shadow then dxDrawText(U.title,U.x+1,U.y+1,U.x+U.w+1,U.y+U.h+1,tocolor(0,0,0,255),_,Z,"center","center",true,false,false,false,false)end;dxDrawText(U.title,U.x,U.y,U.x+U.w,U.y+U.h,a0,_,Z,"center","center",true,false,false,false,false)end end end;table.insert(elements.list,1,self)return self end;elements.window={}function window(N,m,n,o,p,S)local self=dx.new('window',m,n,o,p)self.text=N or''self.style.bgColor=S or self.style.bgColor;self.showTitleBar=true;self.moveable=true;self.closeBtn=button("X",self.w-self.style.titleHeight,0,self.style.titleHeight,self.style.titleHeight,self.style.closeBgColor)self.closeBtn.setParent(self)self.closeBtn.onclick=function()self.visible=false end;self.closeBtn.style.bgHover=self.style.closeBgHover;self.closeBtn.showBorderOnHover=false;self.closeBtn.showBorders=false;self.showBorders=true;local M;function self.draw()if self.showTitleBar and self.style.titleHeight>0 and self.moveable then local m,n=self.drag()if m then self.x=self.x+m;self.y=self.y+n end end;dxDrawRectangle(self.x,self.y,self.w,self.h,self.style.bgColor)if self.showTitleBar and self.style.titleHeight>0 then self.closeBtn.visible=true;if self.ontop then local a2=self.mouseDown()M=a2 and self.mouseOn(self.x,self.y,self.w-self.style.titleHeight,self.style.titleHeight)end;dxDrawRectangle(self.x,self.y,self.w,self.style.titleHeight,self.style.titleBgColor)if self.style.shadow then dxDrawText(self.text,self.x+5+1,self.y+1,self.x+self.w-self.style.titleHeight-10+1,self.y+self.style.titleHeight+1,tocolor(0,0,0,255),1.50,"default","left","center")end;dxDrawText(self.text,self.x+5,self.y,self.x+self.w-self.style.titleHeight-10,self.y+self.style.titleHeight,self.style.color,1.50,"default","left","center")else self.closeBtn.visible=false end end;function self.drawBorders()dxDrawLine(self.x,self.y,self.x+self.w,self.y,self.style.borderColor,self.style.borderSize)if self.showTitleBar then dxDrawLine(self.x,self.y+self.style.titleHeight,self.x+self.w,self.y+self.style.titleHeight,self.style.borderColor,self.style.borderSize)end;dxDrawLine(self.x,self.y+self.h,self.x+self.w,self.y+self.h,self.style.borderColor,self.style.borderSize)dxDrawLine(self.x,self.y,self.x,self.y+self.h,self.style.borderColor,self.style.borderSize)dxDrawLine(self.x+self.w,self.y,self.x+self.w,self.y+self.h,self.style.borderColor,self.style.borderSize)end;local a3,a4=0,0;function self.drag()local H=mouse()if H then if M then local m=H.x-a3;local n=H.y-a4;a3=H.x;a4=H.y;if m~=0 or n~=0 then return m,n end else a3=H.x;a4=H.y end end end;table.insert(elements.window,1,self)self.setontop()return self end;elements.button={}function button(N,m,n,o,p,S)local self=dx.new('button',m,n,o or 115,p or 35)self.text=N or''self.style.bgColor=S or self.style.bgColor;self.showBorders=true;self.showBorderOnHover=false;function self.onKey(K,L)if self.mouseOn()then if K=='mouse1'and not L then return self.onclick end end end;function self.draw()local M=self.mouseOn()local a5=M and self.ontop or false;M=a5 and M;local a2=a5 and self.mouseDown()local a1=M and self.style.bgHover or self.style.bgColor;local S=a2 and self.style.hover or self.style.color;local _=a2 and 1.37 or self.style.fontSize;dxDrawRectangle(self.x,self.y,self.w,self.h,a1)if self.style.shadow then dxDrawText(self.text,self.x+1,self.y+1,self.x+self.w+1,self.y+self.h+1,tocolor(0,0,0,255),_,"default","center","center",true)end;dxDrawText(self.text,self.x,self.y,self.x+self.w,self.y+self.h,S,_,"default","center","center",true)if self.showBorders or M and self.showBorderOnHover then self.drawBorders()end end;function self.drawBorders()dxDrawLine(self.x,self.y,self.x+self.w,self.y,self.style.borderColor,self.style.borderSize)dxDrawLine(self.x,self.y+self.h,self.x+self.w,self.y+self.h,self.style.borderColor,self.style.borderSize)dxDrawLine(self.x,self.y,self.x,self.y+self.h,self.style.borderColor,self.style.borderSize)dxDrawLine(self.x+self.w,self.y,self.x+self.w,self.y+self.h,self.style.borderColor,self.style.borderSize)end;table.insert(elements.button,1,self)return self end;elements.checkbox={}function checkbox(N,m,n,o,p,a6)local self=dx.new('checkbox',m,n,o,p)self.text=N;self.selected=false;self.onclick=a6 or function(s)if s then s()end end;function self.onKey(K,L)if self.mouseOn()then if K=='mouse1'and not L then return self.toggle end end end;function self.draw()local a7=self.h*0.85;dxDrawRectangle(self.x,self.y,self.w,self.h,self.style.bgColor)dxDrawRectangle(self.x,self.y,self.h,self.h)if self.selected then dxDrawRectangle(self.x+a7,self.y+a7,self.h-a7*2,self.h-a7*2,self.style.bgSelected)end;local S=self.mouseOn()and self.ontop and self.style.hover or self.style.color;dxDrawText(self.text,self.x+self.h+5,self.y,self.x+self.w-5,self.y+self.h,S,self.h*0.075,"default","left","center",true)end;function self.toggle()self.selected=not self.selected;self.onclick(self.selected)end;table.insert(elements.checkbox,1,self)return self end;elements.label={}function label(N,m,n,o,p,S,a8,a9,aa,ab,ac)local self=dx.new('label',m,n,o,p)self.text=N;self.color=S or tocolor(255,255,255,255)self.scale=a8 or 1;self.bgVisible=false;self.bgColor=tocolor(0,0,0,200)self.shadow=a9 or false;function self.draw()if self.bgVisible then dxDrawRectangle(self.x,self.y,self.w,self.h,self.bgColor)end;if self.shadow then dxDrawText(self.text,self.x+1,self.y+1,self.x+self.w+1,self.y+self.h+1,tocolor(0,0,0,255),self.scale,aa or"default",ab or"left",ac or"top",true)end;dxDrawText(self.text,self.x,self.y,self.x+self.w,self.y+self.h,self.color,self.scale,aa or"default",ab or"left",ac or"top",true)end;table.insert(elements.label,1,self)return self end;elements.image={}function image(ad,m,n,o,p)local self=dx.new('image',m,n,o,p)self.src=ad;function self.draw()dxDrawImage(self.x,self.y,self.w,self.h,self.src)end;table.insert(elements.image,1,self)return self end;elements.progressbar={}function progressBar(m,n,o,p)local self=dx.new('progressbar',m,n,o or 115,p or 35)self.value=0;function self.draw()dxDrawRectangle(self.x,self.y,self.w,self.h,self.style.bgColor)dxDrawRectangle(self.x+self.style.spacing,self.y+self.style.spacing,self.w-self.style.spacing*2,self.h-self.style.spacing*2,self.style.innerColor)local ae=self.value/100*(self.w-self.style.spacing*2)dxDrawRectangle(self.x+self.style.spacing,self.y+self.style.spacing,ae,self.h-self.style.spacing*2,self.style.progressColor)if self.style.shadow then dxDrawText(self.value.."%",self.x+self.style.spacing+1,self.y+self.style.spacing+1,self.x+self.style.spacing+ae+1,self.y+self.style.spacing+self.h-self.style.spacing*2+1,tocolor(0,0,0,255),self.style.fontSize,"default","center","center",true)end;dxDrawText(self.value.."%",self.x+self.style.spacing,self.y+self.style.spacing,self.x+self.style.spacing+ae,self.y+self.style.spacing+self.h-self.style.spacing*2,self.style.color,self.style.fontSize,"default","center","center",true)end;table.insert(elements.progressbar,1,self)return self end;function alert(af,ag,ah,ai,aj)local self=window("alert",0,0,400,300)self.align("center")showCursor(self.visible)local ak=label(af,0,0,self.w,self.h-60,tocolor(255,255,255,255),1.5,true,"default","center","center")ak.setParent(self)self.closeBtn.onclick=function()showCursor(false)self.destroy()end;if not ah then local n=button(ai or"Ok",0,200)n.setParent(self)n.align('centerX')n.onclick=function()if ag then ag()end;showCursor(false)self.destroy()end end;if ag and ah then local n=button(ai or"yes",60,200)local al=button(aj or"no",225,200)n.setParent(self)al.setParent(self)n.onclick=function()ag()showCursor(false)self.destroy()end;al.onclick=function()ah()showCursor(false)self.destroy()end end;return self end