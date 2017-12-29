/*
 * locate-pointer.c
 * Some windows manager missing option to locate mouse pointer as accessibity feature.
 * To get transparent window need to activate `composite` service for wm.
 * Coded in c / xlib so it can work in most wm's.
 * 
 * Coded by:	Abdellah Chelli
 * Date:	January 2015
 *
 * Original code by: 	Bernhard R. Fischer <bf@abenteuerland.at>
 * 			Cairo graphics and X11/Xlib motion example.
 *			https://www.cypherpunk.at/2014/11/cairo-graphics-and-x11xlib/
 *
 * gcc `pkg-config --cflags x11 cairo` locate-pointer.c -o locate-pointer `pkg-config --libs x11 cairo` -lm
 */

#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/Xutil.h>
#include <cairo.h>
#include <cairo-xlib.h>

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

int cairo_check_event(cairo_surface_t *sfc, int block, double *mx, double *my)
{
   char keybuf[8];
   KeySym key;
   XEvent e;
   XSync(cairo_xlib_surface_get_display(sfc),False);
   for (;;)
   {
      if (block || XPending(cairo_xlib_surface_get_display(sfc)))
         XNextEvent(cairo_xlib_surface_get_display(sfc), &e);
      else 
         return 0;

      switch (e.type)
      {
         case ButtonPress:
            return -e.xbutton.button;
         case KeyPress:
            XLookupString(&e.xkey, keybuf, sizeof(keybuf), &key, NULL);
            return key;
         case  MotionNotify:
            *mx = e.xmotion.x;
            *my = e.xmotion.y;
            
         default:
            //fprintf(stderr, "Dropping unhandled XEevent.type = %d.\n", e.type);
            return 0;
      }
   }
}


static void fullscreen(Display* dpy, Window win)
{
  Atom atoms[2] = { XInternAtom(dpy, "_NET_WM_STATE_FULLSCREEN", False), None };
  XChangeProperty(dpy, win, XInternAtom(dpy, "_NET_WM_STATE", False),
                  XA_ATOM, 32, PropModeReplace, (unsigned char*) atoms, 1);
}


cairo_surface_t *cairo_create_x11_surface(int *x, int *y, double* mx, double *my)
{
   Display *dsp;
   Drawable da;
   Screen *scr;
   int screen;
   cairo_surface_t *sfc;

   XVisualInfo vinfo;
   XSetWindowAttributes win_attr;
   int mousex, mousey;

   if ((dsp = XOpenDisplay(NULL)) == NULL)
      exit(1);
   //XSynchronize(dsp,True);
   screen = DefaultScreen(dsp);
   scr = DefaultScreenOfDisplay(dsp);

   XMatchVisualInfo(dsp, screen, 32, TrueColor, &vinfo);
   win_attr.colormap = XCreateColormap(dsp, DefaultRootWindow(dsp), vinfo.visual, AllocNone);
   win_attr.background_pixel = 0;
   win_attr.border_pixel = 0;

   *x = WidthOfScreen(scr), *y = HeightOfScreen(scr);

   da = XCreateWindow(dsp, DefaultRootWindow(dsp),
           0, 0, *x, *y, 0, vinfo.depth, InputOutput,
           vinfo.visual,
           CWColormap | CWBorderPixel | CWBackPixel, &win_attr);

   fullscreen (dsp, da);

   XSelectInput(dsp, da, PointerMotionMask | ButtonPressMask | KeyPressMask);
   XMapWindow(dsp, da);

   sfc = cairo_xlib_surface_create(dsp, da, vinfo.visual, *x, *y);
   cairo_xlib_surface_set_size(sfc, *x, *y);

   Window rw=DefaultRootWindow(dsp);
   Window cw=da;
   int rx, ry;
   unsigned int mr;
   XQueryPointer(dsp, da, &rw, &cw, &rx , &ry, &mousex, &mousey, &mr);
   *mx = mousex;
   *my = mousey;

   return sfc;
}


void cairo_close_x11_surface(cairo_surface_t *sfc)
{
   Display *dsp = cairo_xlib_surface_get_display(sfc);

   cairo_surface_destroy(sfc);
   XCloseDisplay(dsp);
}

int main(int argc, char **argv)
{
   cairo_surface_t *sfc;
   cairo_t *ctx;
   int x, y;
   struct timespec ts = {0, 5000000};

   double mx, my;
   int c = 0;
   double dr0, dr1, dr2, a;

   int running;

   x = y = 0;

   sfc = cairo_create_x11_surface(&x, &y, &mx, &my);
   ctx = cairo_create(sfc);

   for (running = 1; running;)
   {

      dr0 = 20 * sin(c*M_PI/180.0);
      dr1 = 20 * sin((c+45)*M_PI/180.0);
      dr2 = 20 * sin((c+90)*M_PI/180.0);
      a = c*M_PI/720.0;

      cairo_save (ctx);
      //cairo_set_source_rgba (ctx, 0, 0, 0, 1);
      //cairo_set_operator (ctx, CAIRO_OPERATOR_SOURCE);
      cairo_set_operator (ctx, CAIRO_OPERATOR_CLEAR);
      cairo_paint (ctx); 
      cairo_restore (ctx);

      cairo_push_group(ctx);
      cairo_translate(ctx, mx, my);
      cairo_rotate(ctx,a);
      cairo_translate(ctx, -mx, -my);
      cairo_set_source_rgba(ctx, 0, 0, 0, 0.1);
      cairo_paint(ctx);

      cairo_set_line_join (ctx, CAIRO_LINE_JOIN_MITER);
      cairo_set_source_rgba(ctx, 1, 0, 0, 1);
      cairo_set_line_width (ctx, 30);
      cairo_move_to (ctx, mx-50, my-100-dr0);
      cairo_rel_line_to (ctx, 50, 30);
      cairo_rel_line_to (ctx, 50, -30);
      cairo_move_to (ctx, mx+100+dr0, my-50);
      cairo_rel_line_to (ctx, -30, 50);
      cairo_rel_line_to (ctx, 30, 50);
      cairo_move_to (ctx, mx+50, my+100+dr0);
      cairo_rel_line_to (ctx, -50, -30);
      cairo_rel_line_to (ctx, -50, 30);
      cairo_move_to (ctx, mx-100-dr0, my+50);
      cairo_rel_line_to (ctx, 30, -50);
      cairo_rel_line_to (ctx, -30, -50);
      cairo_stroke(ctx);
      cairo_set_source_rgba(ctx, 1, 0, 0, 0.5);
      cairo_move_to (ctx, mx-50, my-150-dr1);
      cairo_rel_line_to (ctx, 50, 30);
      cairo_rel_line_to (ctx, 50, -30);
      cairo_move_to (ctx, mx+150+dr1, my-50);
      cairo_rel_line_to (ctx, -30, 50);
      cairo_rel_line_to (ctx, 30, 50);
      cairo_move_to (ctx, mx+50, my+150+dr1);
      cairo_rel_line_to (ctx, -50, -30);
      cairo_rel_line_to (ctx, -50, 30);
      cairo_move_to (ctx, mx-150-dr1, my+50);
      cairo_rel_line_to (ctx, 30, -50);
      cairo_rel_line_to (ctx, -30, -50);
      cairo_stroke(ctx);
      cairo_set_source_rgba(ctx, 1, 0, 0, 0.3);
      cairo_move_to (ctx, mx-50, my-200-dr2);
      cairo_rel_line_to (ctx, 50, 30);
      cairo_rel_line_to (ctx, 50, -30);
      cairo_move_to (ctx, mx+200+dr2, my-50);
      cairo_rel_line_to (ctx, -30, 50);
      cairo_rel_line_to (ctx, 30, 50);
      cairo_move_to (ctx, mx+50, my+200+dr2);
      cairo_rel_line_to (ctx, -50, -30);
      cairo_rel_line_to (ctx, -50, 30);
      cairo_move_to (ctx, mx-200-dr2, my+50);
      cairo_rel_line_to (ctx, 30, -50);
      cairo_rel_line_to (ctx, -30, -50);
      cairo_stroke(ctx);
      cairo_pop_group_to_source(ctx);
      cairo_paint(ctx);
      cairo_surface_flush(sfc);

      switch (cairo_check_event(sfc, 0, &mx, &my))
      {
         case 0xff1b:   // Esc
         case -1:       // left mouse button
            running = 0;
            break;
      }
      
      c++;
      nanosleep(&ts, NULL);
   }

   cairo_destroy(ctx);
   cairo_close_x11_surface(sfc);
   return 0;
}