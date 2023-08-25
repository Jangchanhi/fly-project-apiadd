package kr.co.sl.tmap_raster_flutter_sample

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.TextView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.platform.PlatformView

internal class NativeView(
    activity: FlutterActivity,
    context: Context?,
    id: Int,
    creationParams: Map<String?, Any?>?
) :
    PlatformView {

    private val layout: FrameLayout
    override fun getView(): View {
        return layout

    }


    override fun dispose() {

    }


    init {
        layout = FrameLayout(context!!)
        layout.setBackgroundColor(Color.argb(255, 230, 230, 230))
        
    }
}