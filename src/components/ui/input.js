import React from 'react'

export function Input({ className, ...props }) {
  return (
    <input
      className={`w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 ${className}`}
      {...props}
    />
  )
}