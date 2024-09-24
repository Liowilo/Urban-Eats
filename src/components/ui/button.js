import React from 'react'

export function Button({ children, className, variant = 'default', ...props }) {
  const baseStyles = 'px-4 py-2 rounded font-semibold text-sm transition-colors duration-200'
  const variants = {
    default: 'bg-green-600 text-white hover:bg-green-700',
    outline: 'bg-transparent border border-current text-green-600 hover:bg-green-100',
  }

  const variantStyles = variants[variant] || variants.default

  return (
    <button
      className={`${baseStyles} ${variantStyles} ${className}`}
      {...props}
    >
      {children}
    </button>
  )
}