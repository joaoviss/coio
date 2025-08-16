pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--player
player={
 meowths={},
 cnt=0,
 score=0,
 sp=32, flipx=false,
 w=2, h=2,
 dx=0, dy=0,
 acc=3, boost=7, spd=1,
 stand=false, jumping=false, 
 falling=false, running=false,
 cry=false
}

function player:new(x,y,lives)
  local o={x=x,y=y,lives=lives}
  return setmetatable(o,{__index=self}) 
end

function player:draw()
 for m in all(self.meowths) do
  m:draw()
 end
 spr(self.sp,self.x,self.y,2,2,self.flipx)
end

function player:update()
 self.dx *= f
 self.dy += g
 self.running = false
 -- move left
 if btn(⬅️) then
  self.flipx = true
  if self.stand then
   self.running = true
  end
 	 self.dx -= self.acc
 end
-- move right
 if btn(➡️) then
  self.flipx = false
  if self.stand then
   self.running = true
  end
  self.dx += self.acc
 end
-- jump
 if btnp(❎) and self.stand then
  sfx(1)
  self.dy = -self.boost
  self.stand = false
  self.running = false
 end
-- shout
 if btn(🅾️) then
  if btnp(⬆️) then
	  if t==0 then
    	self.cry=true
	    add(self.meowths,meow:new(self.x,self.y,self.flipx,self.spd))
  	  t=50
	 	else
		  t-=1
	  end
	 end
 end
 
 if self.dx < 0 then
  self.dx = limit(self.dx,mdx)
  if collision(self, 'left', 0) or
  self.x<=0 then
   self.dx = 0
  end
 elseif self.dx > 0 then
  self.dx = limit(self.dx,mdx)
  if collision(self, 'right', 0) or
  self.x>=1008 then
   self.dx = 0
  end
 end
 gravity(self)
 self.x += self.dx
 if self.x<0 then
  self.x = 0
 end
 self.cry=false
 for m in all(self.meowths) do
  m:update()
 end
end

function player:animate()
 if self.running then
  if (i%5==0) sfx(0)
  if self.cnt==0 then
   self.sp = self.sp == 42 and 40 or 42
   self.cnt=3
  else
   self.cnt-=1
  end
 elseif self.jumping then
  self.sp = 40
 elseif self.falling then
  self.sp = 44
 elseif self.cry then
  self.sp = 46
 else
  if self.cnt==0 then
   self.sp += self.sp < 38 and 2 or -6
   self.cnt=5
  else
   self.cnt-=1
  end
 end
end

function player:die()
 self.lives-=1
 if self.lives<=0 then
  state='gameover'	
 else
  cx=0 self.x=5 self.y=96
 end

end

function player:hit()
  self.lives-=1
  local dir = self.flipx and 1 or -1
  self.x -= 16*dir
  self.dy -= 4
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0000000006450084500d4500f4501a450214402243000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
00060000190611c0511f04122031280051f000220002200021000220001f0001f000220002200021000220001f0001f0002e0012e0002d0002e0002b0002b0002b0022b005000000000000000000000000000000
