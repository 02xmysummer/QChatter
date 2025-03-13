#ifndef SINGLETON_H
#define SINGLETON_H

#include <iostream>
#include <memory>
#include <mutex>

using namespace std;

/**
 * @brief 通用单例模板类
 * @tparam T 需要实现单例模式的具体类型
 * 
 * 这个类实现了线程安全的单例模式，使用智能指针管理实例的生命周期。
 * 通过将构造函数设为protected，并删除拷贝构造和赋值操作，确保单例的唯一性。
 */
template<typename T>
class Singleton
{
protected:
    // 默认构造函数，protected访问级别确保只有子类可以实例化
    Singleton() = default;

    // 删除拷贝构造函数，防止实例被复制
    Singleton(const Singleton<T> &) = delete;

    // 删除赋值运算符，防止实例被赋值
    Singleton &operator=(const Singleton<T> &st) = delete;

    // 静态成员变量，存储唯一实例的智能指针
    static std::shared_ptr<T> _instance;

public:
    /**
     * @brief 获取单例实例的静态方法
     * @return 返回类型T的共享智能指针
     * 
     * 使用std::call_once确保线程安全的实例化过程
     * 返回指向唯一实例的智能指针
     */
    static std::shared_ptr<T> GetInstance()
    {
        static std::once_flag s_flag;
        std::call_once(s_flag, [&]() { _instance = shared_ptr<T>(new T); });
        return _instance;
    }

    /**
     * @brief 打印实例的内存地址
     * 用于调试目的，验证单例的唯一性
     */
    void PrintAddress() { std::cout << _instance.get() << endl; }

    /**
     * @brief 析构函数
     * 当单例对象被销毁时输出提示信息
     */
    ~Singleton() { std::cout << "this is singleton destruct" << std::endl; }
};

// 初始化静态成员变量
template<typename T>
std::shared_ptr<T> Singleton<T>::_instance = nullptr;

#endif // SINGLETON_H
