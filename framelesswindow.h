#ifndef FRAMELESSWINDOW_H
#define FRAMELESSWINDOW_H

#include <QQuickWindow>
// #include <dwmapi.h>
// #include <windows.h>
// #include <windowsx.h>

class FramelessWindow : public QQuickWindow
{
    Q_OBJECT


public:
    enum MousePosition{
        TOPLEFT = 1, TOP, TOPRIGHT, LEFT, RIGHT, BOTTOMLEFT, BOTTOM, BOTTOMRIGHT, NORMAL
    };
    Q_PROPERTY(MousePosition mouse_pos READ getMouse_pos WRITE setMouse_pos NOTIFY mouse_posChanged FINAL)
    Q_PROPERTY(bool is_resize READ getIs_resize WRITE setIs_resize NOTIFY is_resizeChanged FINAL)

    Q_ENUM(MousePosition);
    explicit FramelessWindow(QWindow *parent = nullptr);

    ~FramelessWindow()  = default;
    MousePosition getMouse_pos() const;
    void setMouse_pos(MousePosition newMouse_pos);

    Q_INVOKABLE void setWindowFlag(bool is_top);
    bool getIs_resize() const;
    void setIs_resize(bool newIs_resize);

signals:
    void mouse_posChanged();

    void is_resizeChanged();

protected:
    void mousePressEvent(QMouseEvent* event);
    void mouseReleaseEvent(QMouseEvent* event);
    void mouseMoveEvent(QMouseEvent* event);

private:
    void setWindowGeometry(const QPointF &pos);
    //设置鼠标形状
    void setCursorIcon();
    //获取鼠标当前位置
    MousePosition getMousePos(QPointF &pos);

    //缩放边距
    int step = 8;
    //鼠标的大概位置
    MousePosition mouse_pos = NORMAL;
    //起始位置
    QPointF start_pos;
    //旧位置
    QPointF old_pos;
    //旧大小
    QSize old_size;

    //窗口大小是否可以调整
    bool is_resize = true;

};

#endif // FRAMELESSWINDOW_H
