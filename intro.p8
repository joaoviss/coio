pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--intro
function intro_init()
 t=0 l=1 c=0 intro=''
 credits={
  'produzido por: \njoaoviss\n',
  'baseado no personagem de: \ngisele henriques\n',
  'com arte de: \ncecihoney\n',
 }
end

function intro_draw()
 cls()
 print(intro,0,0,6)
 print('❎ = pular',86,100,5)
end

function intro_update()
 if l<=#credits then
  if c==0 then
   intro=intro..'coio/> '
   c+=1
  elseif c<=#credits[l] then
   if t<=0 do
    intro=intro..credits[l][c]
    c+=1
    t=5
   else
    t-=1
   end
  else
   intro=intro..'\n'
   l+=1
   c=0
   while t<30 do
    flip()
    t+=1
   end
   t=0
  end
 end
end

