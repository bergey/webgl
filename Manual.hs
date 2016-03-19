-- | Manual translation of part of the WebGL spec into Haskell with JS
-- FFI.  This module does not aim to be complete, only to provide
-- examples of how the automatically generated bindings should work.

module Manual where

type GLenum = Word32
type GLboolean = Bool
type GLbitfield = Word32

newtype WebGLBuffer = WebGLBuffer { unWebGLBuffer :: JSVal }
newtype WebGLFramebuffer = WebGLFramebuffer { unWebGLFramebuffer :: JSVal }

newtype WebGLActiveInfo = WebGLActiveInfo { unWebGLActiveInfo :: JSVal }

-- These names will conflict with others.  Put them in a module for qualified import?

size :: WebGLActiveInfo -> GLint
size = js_size . unWebGLBuffer
foreign import javascript unsafe "$1.size" js_size :: JSVal -> GLInt

type :: WebGLActiveInfo -> GLenum
name :: WebGLActiveInfo -> DOMString

newtype WebGLShaderPrecisionFormat =
  WebGLShaderPrecisionFormat { unWebGLShaderPrecisionFormat :: JSVal }

pattern POINTS = 0x0000
pattern LINES = 0x0001
pattern LINE_LOOP = 0x002

newtype WebGLRenderingContextBase =
  WebGLRenderingContextBase { unWebGLRenderingContextBase :: JSVal }

canvas :: WebGLRenderingContextBase -> IO HTMLCanvasElement
canvas = js_canvas . unWebGLRenderingContext
foreign import javascript unsafe "$1.canvas" js_canvas :: JSVal -> IO HTMLCanvasElement

blendEquationSeparate :: WebGLRenderingContext -> GLenum -> GLenum -> IO ()
blendEquationSeparate (WebGLRenderingContext gl) modeRGB modeAlpha =
  js_blendEquationSeparate gl modeRGB modeAlpha
foreign import javascript unsafe "$1.blendEquationSeparate($2, $3)" js_blendEquationSeparate :: JSVal -> GLenum -> GLenum -> IO ()

attachShader :: WebGLRenderingContextBase -> Maybe WebGLProgram -> Maybe WebGLShader -> IO ()
attachShader (WebGLRenderingContext gl) prog shader = js_attachShader

maybeNull :: Maybe JSVal -> JSVal
maybeNull Nothing = jsNull
maybeNull (Just v) = v
