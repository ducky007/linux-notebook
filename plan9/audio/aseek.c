#include <u.h>
#include <libc.h>
#include <draw.h>
#include <event.h>
#include <keyboard.h>

enum {
  Etick = 256,
};

int pids[2];
int pause;

vlong bufoff;
vlong minoff;
vlong maxoff;
vlong curoff;

void
eresized(int new)
{
  Rectangle r1, r2;
  char buf[32];

  if(new && getwindow(display, Refnone) < 0)
    fprint(2,"can't reattach to window");

  r1 = screen->r;
  r2 = r1;
  if((maxoff - minoff) <= 0)
    r1.max.x = r1.min.x + Dx(r2);
  else
    r1.max.x = r1.min.x + ((vlong)Dx(r2) * (curoff - minoff)) / (maxoff - minoff);
  r2.min.x = r1.max.x;
  draw(screen, r1, display->black, nil, ZP);
  draw(screen, r2, display->white, nil, ZP);
  if(pause){
    strcpy(buf, "pause");

    r2.min = ZP;
    r2.max = stringsize(display->defaultfont, buf);
    r1 = rectsubpt(screen->r, screen->r.min);
    r2 = rectaddpt(r2, subpt(divpt(r1.max, 2), divpt(r2.max, 2)));
    r2 = rectaddpt(r2, screen->r.min);
    r1 = insetrect(r2, -4);
    draw(screen, r1, display->white, nil, ZP);
    border(screen, insetrect(r1, 1), 2, display->black, ZP);
    string(screen, r2.min, display->black, ZP, display->defaultfont, buf);
  }

  flushimage(display, 1);
}

void
usage(void)
{
  fprint(2, "usage: %s [-s | -b buffer]\n", argv0);
  exits("usage");
}

void
killpids(void)
{
  int pid, i;

  pid = getpid();
  for(i=0; i<nelem(pids); i++){
    if(pids[i] <= 0 || pids[i] == pid)
      continue;
    postnote(PNPROC, pids[i], "kill");
    sleep(1);
  }
}

void
main(int argc, char *argv[])
{
  char buf[1024];
  int stream, fd, pid, n;
  vlong o;

  fd = 0;
  stream = 0;

  ARGBEGIN {
  case 'b':
    bufoff = atoll(EARGF(usage()));
    bufoff *= 1024;
    bufoff &= ~0xFLL;
    if(bufoff < 0)
      usage();
  case 's':
    stream = 1;
    break;
  default:
    usage();
  } ARGEND;

  if(stream){
    snprint(buf, sizeof(buf), "/tmp/aseek.%d.tmp", getpid());
    if((fd = create(buf, ORDWR|ORCLOSE, 0600)) < 0)
      sysfatal("create: %r");
    if((pid = rfork(RFMEM|RFPROC)) < 0)
      sysfatal("rfork: %r");
    if(pid == 0){
      for(;;){
        n = sizeof(buf);
        o = maxoff;
        if(bufoff != 0){
          if(((o + n) - curoff) > bufoff){
            sleep(200);
            continue;
          }
          o %= bufoff;
          if((o + n) > bufoff)
            n = bufoff - o;
        }
        if((n = read(0, buf, n)) <= 0)
          break;
        if(pwrite(fd, buf, n, o) != n)
          break;
        maxoff += n;
        if(bufoff != 0 && maxoff > bufoff)
          minoff += n;
      }
      _exits(0);
    }
    pids[0] = pid;
  } else
    maxoff = seek(0, 0, 2);

  atexit(killpids);
  if(initdraw(0, 0, "seeker") < 0)
    sysfatal("initdraw: %r");
  einit(Emouse|Ekeyboard);
  etimer(Etick, 1000);
  eresized(0);

  if((pid = rfork(RFMEM|RFPROC)) < 0)
    sysfatal("rfork: %r");

  if(pid == 0){
    for(;;){
      n = 0;
      if(!pause){
        if(!stream)
          maxoff = seek(fd, 0, 2);
        n = sizeof(buf);
        o = curoff;
        if(o < minoff)
          o = minoff;
        if(o >= maxoff)
          n = 0;
        else if((o + n) > maxoff)
          n = maxoff - o;
        if(bufoff != 0){
          o %= bufoff;
          if((o + n) > bufoff)
            n = bufoff - o;
        }
        if(n > 0)
          n = pread(fd, buf, n, o);
      }
      if(n <= 0){
        sleep(200);
        continue;
      }
      if(write(1, buf, n) != n)
        break;
      curoff += n;
    }
  } else {
    Event e;
    Mouse m;

    pids[1] = pid;
    memset(&m, 0, sizeof(m));
    for(;;){
      n = eread(Emouse|Ekeyboard|Etick, &e);
      if(n == Emouse){
        m=e.mouse;
        if(m.buttons != 0){
          o = m.xy.x - screen->r.min.x;
          if(o < 0) o = 0LL;
          o *= (maxoff - minoff);
          o /= Dx(screen->r);
          o &= ~0xFLL;
          curoff = minoff + o;
          eresized(0);
        }
      } else if(n == Ekeyboard){
        if(e.kbdc == Kdel || e.kbdc == 'q')
          break;
        else if(e.kbdc == ' '){
          pause = !pause;
          eresized(0);
        }
      } else if(n == Etick){
        if(m.buttons == 0)
          eresized(0);
      } else
        break;
    }
  }
  exits(0);
}
