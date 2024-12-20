package io.anyrtc.x2tiktracker_flutter

import android.content.Context
import android.os.Handler
import android.os.Looper
import io.anyrtc.x2tiktracker.DataStats
import io.anyrtc.x2tiktracker.RenewTokenErrCode
import io.anyrtc.x2tiktracker.TKT_CODE
import io.anyrtc.x2tiktracker.X2TikTrackerEngine
import io.anyrtc.x2tiktracker.X2TikTrackerEventHandler
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class X2TikTracker(private val channel: MethodChannel) :X2TikTrackerEventHandler {
    private var x2TikTrackerEngine:X2TikTrackerEngine?=null
    private val handler = Handler(Looper.getMainLooper())
    fun create(context: Context,appId:String){
        x2TikTrackerEngine = X2TikTrackerEngine(context,appId)
    }

    fun release(){
        x2TikTrackerEngine?.release()
    }

    fun startPlay(url:String,share:Boolean):Int{
        return x2TikTrackerEngine?.startPlay(url,share)?:-1
    }

    fun stopPlay():Int{
        return x2TikTrackerEngine?.stopPlay()?:-1
    }

    fun startShare():Int{
        return x2TikTrackerEngine?.startShare()?:-1
    }

    fun stopShare():Int{
        return x2TikTrackerEngine?.stopShare()?:-1
    }

    fun getExUrl():String{
        return x2TikTrackerEngine?.getExUrl().orEmpty()
    }

    fun registerListener(){
        x2TikTrackerEngine?.registerListener(this)
    }

    fun removeListener(){
        x2TikTrackerEngine?.removeListener()
    }


    override fun onLoadDataStats(stats: DataStats) {
        sendEvent(mapOf("event" to "onLoadDataStats", "data" to stats.toMap()))
    }

    override fun onPeerOff(peerId: String, peerData: String) {
        sendEvent(mapOf("event" to "onPeerOff", "peerId" to peerId, "peerData" to peerData))
    }

    override fun onPeerOn(peerId: String, peerData: String) {
        sendEvent(mapOf("event" to "onPeerOn", "peerId" to peerId, "peerData" to peerData))
    }

    override fun onRenewTokenResult(token: String, errorCode: RenewTokenErrCode?) {
        sendEvent(mapOf("event" to "onRenewTokenResult", "token" to token, "errorCode" to errorCode?.name))
    }

    override fun onShareResult(code: TKT_CODE?) {
        sendEvent(mapOf("event" to "onShareResult", "code" to code?.name))
    }

    override fun onTokenExpired() {
        sendEvent(mapOf("event" to "onTokenExpired"))
    }

    override fun onTokenWillExpire() {
        sendEvent(mapOf("event" to "onTokenWillExpire"))
    }


    private fun sendEvent(eventData: Map<String, Any?>) {
        handler.post {
            channel.invokeMethod("onEvent", eventData)
        }
    }


}