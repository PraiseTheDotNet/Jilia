using Plots

N = 2
L = 10
dx = 0.18
dt = 2 * (10 ^ -3)
T = 10

lx = ceil(Int, (L * 2) / dx)
lt = ceil(Int, T / dt)

h = dt / dx

function f(x)
    return -N * (N + 1) * (sech(x) ^ 2)
end

arr = zeros((lt, lx))
x_arr = zeros((lx))

function u(j, i)
    if i < 1
        return arr[j - 1, i + lx]
    elseif i > lx
        return arr[j - 1, i - lx]
    else
        return arr[j - 1, i]
    end
end

# j == t
@gif for j = 1:lt
    t = j * dt
    # i == x
    for i = 1:lx
        x = -L + (i * dx)
        if j == 1
            arr[j, i] = f(x)
            x_arr[i] = x
        elseif j == 2
            arr[j, i] = u(j, i) + 3 * h * u(j, i) * (u(j, i + 1) - u(j, i - 1)) - (h / 2 * (dx ^ 2)) * (u(j, i + 2) - 2 * u(j, i + 1) + 2 * u(j, i - 1) - u(j, i - 2))
        else
            arr[j, i] = u(j - 1, i) + 2 * h * (u(j, i - 1) + u(j, i) + u(j, i + 1)) * (u(j, i + 1) - u(j, i - 1)) - (h / (dx^2)) * (u(j, i + 2) - 2 * u(j, i + 1) + 2 * u(j, i -1) - u(j, i - 2))
        end
    end

    plot(x_arr, -arr[j, :], legend=false)
end
