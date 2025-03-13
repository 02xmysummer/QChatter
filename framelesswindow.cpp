#include "framelesswindow.h"

FramelessWindow::FramelessWindow(QWindow *parent)
    : QQuickWindow{parent}
{
    this->setFlags(Qt::Window | Qt::FramelessWindowHint | Qt::WindowMaximizeButtonHint);
}

void FramelessWindow::mousePressEvent(QMouseEvent *event)
{
    if (!is_resize)
        return;

    this->start_pos = event->globalPosition();
    this->old_pos = this->position();
    this->old_size = this->size();
    event->ignore();

    QQuickWindow::mousePressEvent(event);
}

void FramelessWindow::mouseReleaseEvent(QMouseEvent *event)
{
    if (!is_resize)
        return;

    this->old_pos = this->position();
    QQuickWindow::mouseReleaseEvent(event);
}

void FramelessWindow::mouseMoveEvent(QMouseEvent *event)
{
    if (!is_resize)
        return;
    QPointF pos = event->position();
    if (event->buttons() & Qt::LeftButton) {
        //改变大小
        this->setWindowGeometry(event->globalPosition());
    } else {
        mouse_pos = this->getMousePos(pos);
        this->setCursorIcon();
    }
    QQuickWindow::mouseMoveEvent(event);
}

void FramelessWindow::setWindowGeometry(const QPointF &pos)
{
    QPointF offset = this->start_pos - pos;
    if (offset.x() == 0 && offset.y() == 0)
        return;

    static auto set_geometry_func = [this](const QSize &size, const QPointF &pos) {
        QPointF t_pos = this->old_pos;
        QSize t_size = minimumSize();
        if (size.width() > minimumWidth()) {
            t_pos.setX(pos.x());
            t_size.setWidth(size.width());
        } else if (this->mouse_pos == LEFT) {
            t_pos.setX(this->old_pos.x() + this->old_size.width() - minimumWidth());
        }

        if (size.height() > minimumHeight()) {
            t_pos.setY(pos.y());
            t_size.setHeight(size.height());
        } else if (this->mouse_pos == TOP) {
            t_pos.setY(this->old_pos.y() + this->old_size.height() - minimumHeight());
        }
        this->setGeometry(t_pos.x(), t_pos.y(), t_size.width(), t_size.height());
    };

    switch (this->mouse_pos) {
    case TOPLEFT:
        set_geometry_func(this->old_size + QSize(offset.x(), offset.y()), this->old_pos - offset);
        break;
    case TOP:
        set_geometry_func(this->old_size + QSize(0, offset.y()),
                          this->old_pos - QPointF(0, offset.y()));
        break;
    case TOPRIGHT:
        set_geometry_func(this->old_size - QSize(offset.x(), -offset.y()),
                          this->old_pos - QPointF(0, offset.y()));
        break;
    case LEFT:
        set_geometry_func(this->old_size + QSize(offset.x(), 0),
                          this->old_pos - QPointF(offset.x(), 0));
        break;
    case RIGHT:
        set_geometry_func(this->old_size - QSize(offset.x(), 0), this->position());
        break;
    case BOTTOMLEFT:
        set_geometry_func(this->old_size + QSize(offset.x(), -offset.y()),
                          this->old_pos - QPointF(offset.x(), 0));
        break;
    case BOTTOM:
        set_geometry_func(this->old_size + QSize(0, -offset.y()), this->position());
        break;
    case BOTTOMRIGHT:
        set_geometry_func(this->old_size - QSize(offset.x(), offset.y()), this->position());
        break;
    default:
        break;
    }
}

void FramelessWindow::setCursorIcon()
{
    if (!is_resize)
        return;

    static bool isSet = false;
    if (this->mouse_pos == TOPLEFT || this->mouse_pos == BOTTOMRIGHT) {
        this->setCursor(Qt::SizeFDiagCursor);
        isSet = true;
    } else if (this->mouse_pos == TOPRIGHT || this->mouse_pos == BOTTOMLEFT) {
        this->setCursor(Qt::SizeBDiagCursor);
        isSet = true;
    } else if (this->mouse_pos == LEFT || this->mouse_pos == RIGHT) {
        this->setCursor(Qt::SizeHorCursor);
        isSet = true;
    } else if (this->mouse_pos == TOP || this->mouse_pos == BOTTOM) {
        this->setCursor(Qt::SizeVerCursor);
        isSet = true;
    } else {
        if (isSet) {
            isSet = false;
            this->unsetCursor();
        }
    }
}

bool FramelessWindow::getIs_resize() const
{
    return is_resize;
}

void FramelessWindow::setIs_resize(bool newIs_resize)
{
    if (is_resize == newIs_resize)
        return;
    is_resize = newIs_resize;
    emit is_resizeChanged();
}

FramelessWindow::MousePosition FramelessWindow::getMouse_pos() const
{
    return mouse_pos;
}

void FramelessWindow::setMouse_pos(MousePosition newMouse_pos)
{
    if (mouse_pos == newMouse_pos)
        return;
    mouse_pos = newMouse_pos;
    emit mouse_posChanged();
}

void FramelessWindow::setWindowFlag(bool is_top)
{
    if (is_top) {
        this->setFlags(Qt::Window | Qt::FramelessWindowHint | Qt::WindowMaximizeButtonHint
                       | Qt::WindowStaysOnTopHint);
    } else {
        this->setFlags(Qt::Window | Qt::FramelessWindowHint | Qt::WindowMaximizeButtonHint);
    }
}

FramelessWindow::MousePosition FramelessWindow::getMousePos(QPointF &pos)
{
    int x = pos.x(), y = pos.y(), w = this->width(), h = this->height();

    MousePosition mouse_pos = NORMAL;

    if (x >= 0 && x <= this->step && y >= 0 && y <= this->step) {
        mouse_pos = TOPLEFT;
    } else if (x > this->step && x < (w - this->step) && y >= 0 && y <= this->step) {
        mouse_pos = TOP;
    } else if (x >= (w - this->step) && x <= w && y >= 0 && y <= this->step) {
        mouse_pos = TOPRIGHT;
    } else if (x >= 0 && x <= this->step && y > this->step && y < (h - this->step)) {
        mouse_pos = LEFT;
    } else if (x >= (w - this->step) && x <= w && y > this->step && y < (h - this->step)) {
        mouse_pos = RIGHT;
    } else if (x >= 0 && x <= this->step && y >= (h - this->step) && y < h) {
        mouse_pos = BOTTOMLEFT;
    } else if (x >= this->step && x < (w - this->step) && y >= (h - this->step) && y <= h) {
        mouse_pos = BOTTOM;
    } else if (x >= (w - this->step) && x <= w && y >= (h - this->step) && y <= h) {
        mouse_pos = BOTTOMRIGHT;
    }
    return mouse_pos;
}
